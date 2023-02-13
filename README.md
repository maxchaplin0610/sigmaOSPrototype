# SigmaOS for iPhone

Hey! Welcome to my SigmaOS for iphone prototype inspired by the SigmaOS browser on mac - which is awesome!

You can [download on TestFlight here](https://testflight.apple.com/join/53X9tU1z)!
  

This Prototype has many of the productivity features the mac version has including :

🗂️ **Group** tabs easily

✏️ **Rename** tabs to what they mean to you

🔒 **Lock** tabs that you really care about

😴 **Snooze** tabs to hide them

✅ **Mark** tabs as done

& More!

  

## Workspaces!

Effortlessly organise your tabs into powerful workspaces and easily browse between them to quickly find what you're looking for.

![Scroll Detection - Hides / Shows Bottom Nav Menu Based On Scroll Direction](https://github.com/maxchaplin0610/sigmaOSPrototype/blob/main/workspaces_1.gif)


## Tabs
Tabs can be renamed to what they mean to you to make your browser truly yours. As well as being marked as done, locked or snoozed!

![Scroll Detection - Hides / Shows Bottom Nav Menu Based On Scroll Direction](https://github.com/maxchaplin0610/sigmaOSPrototype/blob/main/renameTab_1.gif)

## Search With AI

Easily access advanced AI answers powered by OpenAI's ChatGPT

![Scroll Detection - Hides / Shows Bottom Nav Menu Based On Scroll Direction](https://github.com/maxchaplin0610/sigmaOSPrototype/blob/main/AISearch.gif)

  

## Search Suggestions - Powered By Google
Google search suggestions displayed when editing search query.

![Scroll Detection - Hides / Shows Bottom Nav Menu Based On Scroll Direction](https://github.com/maxchaplin0610/sigmaOSPrototype/blob/main/gogoleSearchsuggestions.gif)

  

## Auto-Complete - Backed By Search History

Search bar auto-completes queries based on previous searches.

![enter image description here](https://github.com/maxchaplin0610/sigmaOSPrototype/blob/main/historySuggestion.gif)



## Search History

Users search history is stored to power query suggestions as well as a allowing users to quickly go back to old urls.

![enter image description here](https://github.com/maxchaplin0610/sigmaOSPrototype/blob/main/searchHistory.png)

  
## Search Natural Language or URL
A simple combination of a URL extension followed and a short function to determine if the searchTerm is valid results in a seamless search experience.

```
extension URL {
    
    func isReachable(completion: @escaping (Bool) -> ()) {
        
        var request = URLRequest(url: self)
        request.httpMethod = "HEAD"
        URLSession(configuration: .default)
          .dataTask(with: request) { (_, response, error) -> Void in
            guard error == nil else {
              print("fgh Error:", error ?? "")
                completion(false)
              return
            }

            guard (response as? HTTPURLResponse)?
              .statusCode == 200 else {
                print("fgh \(200)")
                completion(false)
                return
            }
              print("fgh true")
              completion(true)
          }
          .resume()
      
    }
}

```
```

func getURLfromString(searchTerm: String, completion: @escaping (URL?) -> ()) {
    
    let url = URL(string: "searchTerm")
    
    if url != nil {
        
        url?.isReachable { success in
            if success {
                
                // If searchTerm conforms to URL and is valid (200) then complete with no modification
                completion(url)
                
                
            } else {
                
                // Check if searchTerm is a domain but requires "https://" e.g >>> youtube.com is not valid however "https://youtube.com" is valid
                let alteredURLString = "https://\(searchTerm)"
                let alteredURL = URL(string: alteredURLString)
                alteredURL?.isReachable(completion: { success2 in
                    
                    if success2 {
                        
                        // If alteredURL conforms to URL and is valid (200) then complete
                        completion(url)
                        
                    } else {
                        
                        // If all else fails, modify searchTerm and search with google
                        let newString = searchTerm.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
                        let googleSearchURLString = "https://www.google.com/search?q=\(newString)"
                        let googleSearchURL = URL(string: googleSearchURLString)
                        
                        completion(googleSearchURL)
                    }
                    
                })
                
                
            }
        }
    }
    
    
}

```

## Favicons

Using a little known google API, favicons are displayed to visually represent URLs.

```

struct FavIcon {

enum Size: Int, CaseIterable { case s = 16, m = 32, l = 64, xl = 128, xxl = 256, xxxl = 512 }

private let domain: String

init(_ domain: String) { self.domain = domain }

subscript(_ size: Size) -> String { "https://www.google.com/s2/favicons?sz=\(size.rawValue)&domain=\(domain)"

}

```

Used like this :

```

AsyncImage(url: URL(string: FavIcon(https://www.facebook.com/)[.l]))

```

Would display the facebook logo with [.l] meaning large resolution (64 x 64).

  

## Scroll Detection

Hides / Shows Bottom Nav Menu Based On Scroll Direction.

  

![Scroll Detection - Hides / Shows Bottom Nav Menu Based On Scroll Direction](https://github.com/maxchaplin0610/sigmaOSPrototype/blob/main/scrollDetection.gif)

  

## Auto Select

Search bar text is auto selected when opened for quicker search.

```

.onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in

  if let textField = obj.object as? UITextField {

  textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)

  }

}

```

![enter image description here](https://github.com/maxchaplin0610/sigmaOSPrototype/blob/main/autoSelect.gif)
