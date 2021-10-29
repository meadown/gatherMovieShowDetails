//
//	PersonImages.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PersonImages : NSObject, NSCoding{

	var images : [Backdrop]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
        images = [Backdrop]()
		if let imagesArray = dictionary["profiles"] as? [[String:Any]]{
			for dic in imagesArray{
				let value = Backdrop(fromDictionary: dic)
                images.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if images != nil{
			var dictionaryElements = [[String:Any]]()
			for imagesElement in images {
				dictionaryElements.append(imagesElement.toDictionary())
			}
			dictionary["profiles"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
        images = aDecoder.decodeObject(forKey :"profiles") as? [Backdrop]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if images != nil{
			aCoder.encode(images, forKey: "profiles")
		}

	}

}
