//
//  main.swift
//  FolderUitlity
//
//  Created by Jas Sobolewski on 2023-07-29.
//

import Foundation


func isValidFolderName(_ folderName: String,_ show: Bool) -> Bool {
    let disallowedCharacters = CharacterSet(charactersIn: "/\\:*?\"<>|")
    
    if folderName.rangeOfCharacter(from: disallowedCharacters) != nil
    {
        print("Disallowed characters Used Not a valid folder name")
        return false // Contains disallowed characters
    }
    if folderName.isEmpty
    {
        if(show)
        {
            print("Empty input Not vaild folder name")
        }
        return false // Empty folder name not allowed
    }
    
    // Additional checks (e.g., reserved names, length limitations) can be added here based on the specific OS/file system rules.

    return true
}


let fileManager = FileManager.default
let desktopURL = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first!


var folderNames: [String] = []


var inputVaild = false;


print("Enter the name of the folder you want named on the desktop:")

while !inputVaild
{
   
    if let name = readLine()
    {
        if isValidFolderName(name,true)
        {
            folderNames.append(name)
            inputVaild = true;
        }
    }
    
}

print("Now enter the name of your sub folders (press 'Enter' to finish):")
while inputVaild
{
   
    if let name = readLine()
    {
        if isValidFolderName(name,false)
        {
            folderNames.append(name)
        }
        else if(name.isEmpty)
        {
            inputVaild = false;
        }
    }
    
}





let folderURL = desktopURL.appendingPathComponent(folderNames[0])

do {
    try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: false, attributes: nil)
    
    print("Parent Folder created successfully!")
    

    for names in 1..<folderNames.count
    {
        
        let temp = folderURL.appending(path: folderNames[names])
    
        try FileManager.default.createDirectory(at: temp, withIntermediateDirectories: true, attributes: nil)
                    print("Folder created at: \(temp)")
    }
} catch {
    print("Error creating folder: \(error)")
}



