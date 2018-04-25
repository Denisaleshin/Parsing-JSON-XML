//
//  XMLParsing.swift
//  hplus-sports
//
//  Created by Saul Mora on 5/27/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import Foundation

enum XMLParsingError: Error
{
    case unknown
}

func parseXML<T>(data: Data, elementName: String) throws -> [T] where T: JSONDecodable
{
    let parser = XMLParser(data: data)
    let parserDelegate = XMLObjectDecoder(elementName)
    
    parser.delegate = parserDelegate
    
    if !parser.parse() {
        throw parser.parserError ?? XMLParsingError.unknown
    }
    
    let objects: [JSONObject] = parserDelegate.parsedObjects
    return try objects.map(decode)
}

class XMLObjectDecoder: NSObject, XMLParserDelegate
{
    private(set) var parsedObjects: [JSONObject] = []
    
    let elementName: String
    init(_ elementName: String)
    {
        self.elementName = elementName
    }
    
    func parserDidStartDocument(_ parser: XMLParser)
    {
        parsedObjects = []
    }
    
    private var currentElementData: JSONObject?
    private var currentKey: String?
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        if elementName == self.elementName
        {
            currentElementData = [:]
        }
        else
        {
            currentKey = elementName
        }
    }
    
    private var currentValue: String?
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if currentValue == nil
        {
            currentValue = String()
        }
        currentValue?.append(string)
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        defer {
            currentValue = nil
            currentKey = nil
        }
        
        if elementName == self.elementName, let currentElementData = currentElementData
        {
            parsedObjects.append(currentElementData)
            self.currentElementData = nil
        }
        else if let currentKey = currentKey, let currentValue = currentValue
        {
            currentElementData?[currentKey] = currentValue
        }
    }
}
