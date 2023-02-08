# SigmaOS for iPhone

Hey! Welcome to my SigmaOS for iphone prototype inspired by the SigmaOS browser on mac - which is awesome!

You can [download on TestFlight here](https://sigmaos.com/)!
  

This Prototype has many of the productivity features the mac version has including :

🗂️ **Group** tabs easily

✏️ **Rename** tabs to what they mean to you

🔒 **Lock** tabs that you really care about

😴 **Snooze** tabs to hide them

✅ **Mark** tabs as done

  

## Workspaces!

Effortlessly organise your tabs into powerful workspaces and easily browse between them to quickly find what you're looking for.

![Scroll Detection - Hides / Shows Bottom Nav Menu Based On Scroll Direction](https://github.com/maxchaplin0610/sigmaOSPrototype/blob/main/workspaces.gif)


## Tabs
Tabs can be renamed to what they mean to you to make your browser truly yours. As well as being marked as done, locked or snoozed!

![Scroll Detection - Hides / Shows Bottom Nav Menu Based On Scroll Direction](https://github.com/maxchaplin0610/sigmaOSPrototype/blob/main/Simulator%20Screen%20Recording%20-%20iPhone%2014%20Pro%20Max%20-%202023-02-08%20at%2019.30.52_1.gif?raw=true)

  

## Search Suggestions - Powered By Google
Google search suggestions displayed when editing search query.

![Scroll Detection - Hides / Shows Bottom Nav Menu Based On Scroll Direction](https://github.com/maxchaplin0610/sigmaOSPrototype/blob/main/gogoleSearchsuggestions.gif)

  

## Auto-Complete - Backed By Search History

Search bar auto-completes queries based on search history.

![enter image description here](https://github.com/maxchaplin0610/sigmaOSPrototype/blob/main/historySuggestion.gif)



## Search History

Users search history is stored to power query suggestions as well as a allowing users to quickly go back to old urls.

![enter image description here](https://github.com/maxchaplin0610/sigmaOSPrototype/blob/main/searchHistory.png)

  

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

if let textField = obj.object **as**? UITextField {

textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)

}

}

```

![enter image description here](https://github.com/maxchaplin0610/sigmaOSPrototype/blob/main/autoSelect.gif)
