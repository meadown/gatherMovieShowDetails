//
//  Constants.swift
//  MovieShow
//
//  Created by Danyal on 22/07/2021.
//

import UIKit

class Constants{
    
    
    static var summaryCellHeight : CGFloat =  150.0
    static var bannderAdUnitID = ""
    static var nativeAdUnitID = ""
    static var InterstitialAdUnitID = "ca-app-pub-6070224121254548/6280856833"

//    static var youtubeBaseUrl = "https://youtu.be/"
    static var youtubeBaseUrl = "https://www.youtube.com/watch?v="

    
    static var tvID = "tvID"
    static var personID = "personID"
    static var seasonID = "seasonID"
    static var genreID = "genreID"
    static var pageNumber = "pageNumber"
    static var categorName = "{categoryName}"//movieOrTV ?? "tv"

    
    static var apiKey = "?api_key=" + "cb18af292fe58b8cccf251899c845834"
//    static var genreAnimation = "with_genres=16"
    static var baseUrl = "https://api.themoviedb.org/3"
    
    static var keyPart = "\(apiKey)"//&\(genreAnimation)"
    //Home Apis
    static var recentMovieUrl = baseUrl + "/\(categorName)/now_playing\(keyPart)"
    static var onAirMovieUrl = baseUrl + "/\(categorName)/upcoming\(keyPart)"
    
    static var recentUrl = baseUrl + "/\(categorName)/airing_today\(keyPart)"
    static var onAirUrl = baseUrl + "/\(categorName)/on_the_air\(keyPart)"
    static var popularUrl = baseUrl + "/\(categorName)/popular\(keyPart)"
    static var topRatedUrl = baseUrl + "/\(categorName)/top_rated\(keyPart)"
    
    //Search
    static var searchUrl = baseUrl + "/search/\(categorName)/\(keyPart)&include_adult=false" // append page and query str "&query=***" "&page=*"
    static var query = "&query="
    
    //Tv details
    static var tvDetailsUrl = baseUrl + "/\(categorName)/\(tvID)" + "\(apiKey)"
    static var tvCast = baseUrl + "/\(categorName)/\(tvID)/credits" + "\(apiKey)"
    static var tvImages = baseUrl + "/\(categorName)/\(tvID)/images" + "\(apiKey)"
    static var tvVideos = baseUrl + "/\(categorName)/\(tvID)/videos" + "\(apiKey)"

    static var cast = "credits"
    static var videos = "videos"
    static var images = "images"
    static var appendToResponse = "&append_to_response="
    
    static var tvDetailsAllUrl = baseUrl + "/\(categorName)/\(tvID)" + "\(apiKey)" + "\(appendToResponse)\(cast),\(videos),\(images)"

    static var discoverTvUrl = baseUrl + "/discover/\(categorName)" + apiKey  + "&sort_by=popularity.desc&with_genres=\(genreID)"
//    https://api.themoviedb.org/3/tv/60572/season/1?api_key=cb18af292fe58b8cccf251899c845834&language=en-US
    //Season Details
    static var seasonDetailsUrl = baseUrl + "/tv/\(tvID)" + "/season/\(seasonID)" + "\(apiKey)"
    
    //Person Details
    static var personDetailsUrl = baseUrl + "/person/\(personID)" + apiKey + appendToResponse  + images

    //Original Image
    static var baseImgUrl = "https://www.themoviedb.org/t/p/"
    
    static var width200Img = "w200"
    static var width300Img = "w300"
    static var width500Img = "w500"
    static var height100Img = "h100"
    
    static var orginalImg = "original"

    
    
    static var appOpenCount : Int{
           get{
               return UserDefaults.standard.integer(forKey: "appOpenCount")
           }
           set{
               UserDefaults.standard.set(newValue, forKey: "appOpenCount")
           }
       }
    
    static var movieOrTV : String?{
           get{
            return UserDefaults.standard.string(forKey: "movieOrTV")
           }
           set{
               UserDefaults.standard.set(newValue, forKey: "movieOrTV")
           }
       }
    
}
