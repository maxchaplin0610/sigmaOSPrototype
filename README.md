# SigmaOS for iPhone

Hey! Welcome to my SigmaOS for iphone prototype inspired by the SigmaOS browser on mac - which is awesome!

You can [download on TestFlight here](https://sigmaos.com/)!
  

This IOS version has many of the productivity features the mac version has including :

🗂️ **Group** tabs easily

✏️ **Rename** tabs to what they mean to you

🔒 **Lock** tabs that you really care about

😴 **Snooze** tabs to hide them

✅ **Mark** tabs as done

  

## Workspaces!

Effortlessly organise your tabs into powerful workspaces and easily browse between them to quickly find what you're looking for.

![Scroll Detection - Hides / Shows Bottom Nav Menu Based On Scroll Direction](https://yubi.fitness/wp-content/uploads/2023/02/Simulator-Screen-Recording-iPhone-14-Pro-Max-2023-02-08-at-17.41.34_1.gif)

  

## Features

Intuitive design is imperative when creating a productivity when efficiency is key. That's why this prototype has design features that make navigation quick!

  

### Search Suggestions - Powered By Google
Google search suggestions displayed when editing search query

  

![Scroll Detection - Hides / Shows Bottom Nav Menu Based On Scroll Direction](https://yubi.fitness/wp-content/uploads/2023/02/Simulator-Screen-Recording-iPhone-14-Pro-Max-2023-02-08-at-17.36.37.gif)

  

## Auto-Complete - Backed By Search History

Search bar auto-completes queries based on search history

![enter image description here](https://yubi.fitness/wp-content/uploads/2023/02/suggestion.gif)


## Search History

Users search history is stored to power query suggestions as well as a allowing users to quickly go back to old urls.

![enter image description here](https://yubi.fitness/wp-content/uploads/2023/02/searchHistory.png)

  

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

Would display the facebook logo with [.l] meaning large resolution (64 x 64)

  

## Scroll Detection

Hides / Shows Bottom Nav Menu Based On Scroll Direction

  

![Scroll Detection - Hides / Shows Bottom Nav Menu Based On Scroll Direction](https://yubi.fitness/wp-content/uploads/2023/02/scrollDetection2.gif)

  

## Auto Select

Search bar text is auto selected when opened for quicker search

```

.onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in

if let textField = obj.object **as**? UITextField {

textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)

}

}

```

![enter image description here](https://yubi.fitness/wp-content/uploads/2023/02/autSelect.gif)
