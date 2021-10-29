//
//	PersonDetail.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PersonDetail : NSObject, NSCoding{

	var adult : Bool!
	var alsoKnownAs : [String]!
	var biography : String!
	var birthday : String!
	var deathday : AnyObject!
	var gender : Int!
	var homepage : String!
	var id : Int!
	var images : PersonImages!
	var imdbId : String!
	var knownForDepartment : String!
	var name : String!
	var placeOfBirth : String!
	var popularity : Float!
	var profilePath : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		adult = dictionary["adult"] as? Bool
		alsoKnownAs = dictionary["also_known_as"] as? [String]
		biography = dictionary["biography"] as? String
		birthday = dictionary["birthday"] as? String
		deathday = dictionary["deathday"] as? AnyObject
		gender = dictionary["gender"] as? Int
		homepage = dictionary["homepage"] as? String
		id = dictionary["id"] as? Int
		if let imagesData = dictionary["images"] as? [String:Any]{
			images = PersonImages(fromDictionary: imagesData)
		}
		imdbId = dictionary["imdb_id"] as? String
		knownForDepartment = dictionary["known_for_department"] as? String
		name = dictionary["name"] as? String
		placeOfBirth = dictionary["place_of_birth"] as? String
		popularity = dictionary["popularity"] as? Float
		profilePath = dictionary["profile_path"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if adult != nil{
			dictionary["adult"] = adult
		}
		if alsoKnownAs != nil{
			dictionary["also_known_as"] = alsoKnownAs
		}
		if biography != nil{
			dictionary["biography"] = biography
		}
		if birthday != nil{
			dictionary["birthday"] = birthday
		}
		if deathday != nil{
			dictionary["deathday"] = deathday
		}
		if gender != nil{
			dictionary["gender"] = gender
		}
		if homepage != nil{
			dictionary["homepage"] = homepage
		}
		if id != nil{
			dictionary["id"] = id
		}
		if images != nil{
			dictionary["images"] = images.toDictionary()
		}
		if imdbId != nil{
			dictionary["imdb_id"] = imdbId
		}
		if knownForDepartment != nil{
			dictionary["known_for_department"] = knownForDepartment
		}
		if name != nil{
			dictionary["name"] = name
		}
		if placeOfBirth != nil{
			dictionary["place_of_birth"] = placeOfBirth
		}
		if popularity != nil{
			dictionary["popularity"] = popularity
		}
		if profilePath != nil{
			dictionary["profile_path"] = profilePath
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         adult = aDecoder.decodeObject(forKey: "adult") as? Bool
         alsoKnownAs = aDecoder.decodeObject(forKey: "also_known_as") as? [String]
         biography = aDecoder.decodeObject(forKey: "biography") as? String
         birthday = aDecoder.decodeObject(forKey: "birthday") as? String
         deathday = aDecoder.decodeObject(forKey: "deathday") as? AnyObject
         gender = aDecoder.decodeObject(forKey: "gender") as? Int
         homepage = aDecoder.decodeObject(forKey: "homepage") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         images = aDecoder.decodeObject(forKey: "images") as? PersonImages
         imdbId = aDecoder.decodeObject(forKey: "imdb_id") as? String
         knownForDepartment = aDecoder.decodeObject(forKey: "known_for_department") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         placeOfBirth = aDecoder.decodeObject(forKey: "place_of_birth") as? String
         popularity = aDecoder.decodeObject(forKey: "popularity") as? Float
         profilePath = aDecoder.decodeObject(forKey: "profile_path") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if adult != nil{
			aCoder.encode(adult, forKey: "adult")
		}
		if alsoKnownAs != nil{
			aCoder.encode(alsoKnownAs, forKey: "also_known_as")
		}
		if biography != nil{
			aCoder.encode(biography, forKey: "biography")
		}
		if birthday != nil{
			aCoder.encode(birthday, forKey: "birthday")
		}
		if deathday != nil{
			aCoder.encode(deathday, forKey: "deathday")
		}
		if gender != nil{
			aCoder.encode(gender, forKey: "gender")
		}
		if homepage != nil{
			aCoder.encode(homepage, forKey: "homepage")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if images != nil{
			aCoder.encode(images, forKey: "images")
		}
		if imdbId != nil{
			aCoder.encode(imdbId, forKey: "imdb_id")
		}
		if knownForDepartment != nil{
			aCoder.encode(knownForDepartment, forKey: "known_for_department")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if placeOfBirth != nil{
			aCoder.encode(placeOfBirth, forKey: "place_of_birth")
		}
		if popularity != nil{
			aCoder.encode(popularity, forKey: "popularity")
		}
		if profilePath != nil{
			aCoder.encode(profilePath, forKey: "profile_path")
		}

	}

}
