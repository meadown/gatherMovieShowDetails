//
//	SeasonDetail.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class SeasonDetail : NSObject, NSCoding{

	var id : String!
	var airDate : String!
	var episodes : [Episode]!
	var name : String!
	var overview : String!
	var posterPath : String!
	var seasonNumber : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["_id"] as? String
		airDate = dictionary["air_date"] as? String
		episodes = [Episode]()
		if let episodesArray = dictionary["episodes"] as? [[String:Any]]{
			for dic in episodesArray{
				let value = Episode(fromDictionary: dic)
				episodes.append(value)
			}
		}
		name = dictionary["name"] as? String
		overview = dictionary["overview"] as? String
		posterPath = dictionary["poster_path"] as? String
		seasonNumber = dictionary["season_number"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["_id"] = id
		}
		if airDate != nil{
			dictionary["air_date"] = airDate
		}
		if episodes != nil{
			var dictionaryElements = [[String:Any]]()
			for episodesElement in episodes {
				dictionaryElements.append(episodesElement.toDictionary())
			}
			dictionary["episodes"] = dictionaryElements
		}
		if name != nil{
			dictionary["name"] = name
		}
		if overview != nil{
			dictionary["overview"] = overview
		}
		if posterPath != nil{
			dictionary["poster_path"] = posterPath
		}
		if seasonNumber != nil{
			dictionary["season_number"] = seasonNumber
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         airDate = aDecoder.decodeObject(forKey: "air_date") as? String
         episodes = aDecoder.decodeObject(forKey :"episodes") as? [Episode]
         name = aDecoder.decodeObject(forKey: "name") as? String
         overview = aDecoder.decodeObject(forKey: "overview") as? String
         posterPath = aDecoder.decodeObject(forKey: "poster_path") as? String
         seasonNumber = aDecoder.decodeObject(forKey: "season_number") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "_id")
		}
		if airDate != nil{
			aCoder.encode(airDate, forKey: "air_date")
		}
		if episodes != nil{
			aCoder.encode(episodes, forKey: "episodes")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if overview != nil{
			aCoder.encode(overview, forKey: "overview")
		}
		if posterPath != nil{
			aCoder.encode(posterPath, forKey: "poster_path")
		}
		if seasonNumber != nil{
			aCoder.encode(seasonNumber, forKey: "season_number")
		}

	}

}
