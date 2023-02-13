//
//  ContentView.swift
//  sigmaOS
//
//  Created by Max Chaplin on 05/02/2023.
//

import SwiftUI
import WebKit

struct ContentView: View {
    
    @EnvironmentObject var model: SwiftUIWebViewModel
    
    @State var url : String = "https://www.google.com/"
    @State var quickDebounceURL : String = "https://www.google.com/"
    
    let isScrollingDown = NotificationCenter.default
                .publisher(for: NSNotification.Name("isScrollingDown"))
    
    @FocusState var isSearchFocused: Bool
    @State var isSearchFocused2: Bool = false
    @State var isFullSearchShowing: Bool = true
    @State var isMenuShowing : Bool = true
    
    @State var isbrowserTabSelectionShowing : Bool = true
    
    @State var progress : Double = 1.0
    
    @State var currentWorkspace : workspace = workspace()
    
    @State var currentWorkspaceIndex: Int = 0
    @State var currentbrowserTabIndex: Int = 0
    
    @State var height : CGFloat = 250
    
    @State var searchSuggestions = suggestions(suggestions: [])
    @State var isSuggestionsLoading: Bool = true
    
    @State var isJustBrowsing : Bool = false
    
    @State var isHistoryShowing: Bool = false
    
    @State var isLogoAnimationShowing: Bool = true
    
    var body: some View {
        
        ZStack {

            //model.webViews[model.currentWorkspaceIndex].webviews[model.currentTabIndex]
            if model.workspaces.count != 0 && model.webViews.count != 0 && model.currentWorkspaceIndex < model.webViews.count {
                
                if model.currentTabIndex < model.webViews[model.currentWorkspaceIndex].webviews.count {
                    
                    VStack(spacing: 0) {
                        
                        ZStack {
                            
                            if model.workspaces.count != 0 || self.isJustBrowsing == true {
                                
                                /*
                                if self.isSearchFocused && self.isSuggestionsLoading == false && self.searchSuggestions.suggestions.count != 0 {
                                    
                                    VStack(alignment: .leading) {
                                        
                                        HStack(alignment: .center) {
                                            
                                            // Placeholder
                                            AsyncImage(url: URL(string: FavIcon("https://www.google.com/")[.l])) { image in
                                                
                                                image
                                                    .resizable()
                                                    .frame(width: 40, height: 40, alignment: .center)
                                                    .cornerRadius(10)
                                                
                                            } placeholder: {
                                                
                                            }
                                            .frame(width: 40, height: 40, alignment: .center)
                                            
                                            Spacer()
                                            
                                            VStack(alignment: .center, spacing: 5) {
                                                
                                                
                                                
                                                Text("Suggestions")
                                                    .bold()
                                                
                                                
                                                HStack(alignment: .center) {
                                                    
                                                    Text("powered by google")
                                                        .font(.caption)
                                                        .foregroundColor(.gray)
                                                    
                                                }
                                                
                                                
                                                
                                            }
                                            
                                            
                                            Spacer()
                                            
                                            Button {
                                                
                                                isSuggestionsLoading = true
                                                
                                            } label: {
                                                
                                                Image(systemName: "xmark")
                                                    .font(.title2)
                                                    .frame(width: 40, height: 40, alignment: .center)
                                                    .foregroundColor(.primary)
                                                    .background(Color("background"))
                                                    .cornerRadius(10)
                                            }
                                            
                                            
                                            

                                            
                                        }
                                        .padding(.horizontal, 10)
                                        .padding(.top, 10)
                                        
                                        ScrollView {
                                            
                                            VStack(spacing: 0) {
                                                
                                                ForEach(0..<self.searchSuggestions.suggestions.count, id: \.self) { i in
                                                    
                                                    let suggestion = self.searchSuggestions.suggestions[i]
                                                    
                                                    Button {
                                                        
                                                        DispatchQueue.main.async {
                                                            self.isSearchFocused = false
                                                        }
                                                        
                                                        let newString = suggestion.value.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
                                                        let url = URL(string: newString)
                                                        
                                                        url?.isReachable { success in
                                                            if success {
                                                                // Load url
                                                                DispatchQueue.main.async {
                                                                    model.urlString = self.url
                                                                    model.loadUrl()
                                                                }
                                                                print("success")
                                                                
                                                                
                                                            } else {
                                                                
                                                                // Search with google
                                                                
                                                                DispatchQueue.main.async {
                                                                    model.urlString = "https://www.google.com/search?q=\(newString)"
                                                                    model.loadUrl()
                                                                }
                                                                print("success.o")
                                                                
                                                            }
                                                        }
                                                        
                                                    } label: {
                                                        
                                                        HStack {
                                                            
                                                            Text(suggestion.value)
                                                                .foregroundColor(.primary)
                                                            
                                                            Spacer()
                                                            
                                                        }
                                                        .padding(.vertical)
                                                        .padding(.horizontal, 10)
                                                        
                                                    }
                                                    
                                                    Rectangle()
                                                        .frame(height: 1)
                                                        .foregroundColor(Color.primary.opacity(0.2))
                                                        .padding(.horizontal, 10)
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    .background(Color("accent"))
                                    .cornerRadius(10)
                                    
                                }
                                 */
                                
                                
                                ZStack(alignment: .top) {
                                    
                                    ForEach(0..<model.webViews.count, id: \.self) { i in
                                        let workspace = model.webViews[i].webviews
                                        ForEach(0..<workspace.count, id: \.self) { ii in
                                            
                                            WebView(webView: $model.webViews[i].webviews[ii])
                                                .scaleEffect(isbrowserTabSelectionShowing ? 1.25 : 1)
                                                .blur(radius: isbrowserTabSelectionShowing ? 10 : 0)
                                                .cornerRadius(10)
                                                .animation(.interpolatingSpring(stiffness: 200, damping: 15), value: isFullSearchShowing)
                                                .animation(.interpolatingSpring(stiffness: 200, damping: 15), value: isbrowserTabSelectionShowing)
                                                .padding(.bottom, 5)
                                                .opacity(model.currentWorkspaceIndex == i && model.currentTabIndex == ii ? 1 : 0)
                                            
                                        }
                                    }
                                    
                                    
                                    
                                }
                                
                            }
                            
                            if isSearchFocused {
                                searchFocusedView(urlString: self.$url, isSearchFocused: $isSearchFocused2)
                                    .onChange(of: isSearchFocused2) { newValue in
                                        self.isSearchFocused = false
                                    }
                            }
                            
                            
                        }
                        
                        ZStack(alignment: .bottomLeading) {
                            
                            ZStack {
                                    
                                    ZStack(alignment: .center) {
                                        
                                        TextField("Search or enter a url", text: $url)
                                            .multilineTextAlignment(isSearchFocused ? .leading : .center)
                                            .submitLabel(.search)
                                            .focused($isSearchFocused)
                                            .opacity(isSearchFocused ? 1 : 0)
                                            .autocorrectionDisabled(true)
                                            .textInputAutocapitalization(.never)
                                            .onChange(of: model.historySuggestion, perform: { newValue in
                                                model.historySuggestion = ""
                                            })
                                            .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
                                                if let textField = obj.object as? UITextField {
                                                    textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                                                }
                                            }
                                            .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)) { (output) in
                                                
                                                print("TextChange : \(self.url)")
                                                
                                                getHistorySuggestions(searchTerm: self.url) { string, change in
                                                    
                                                    if string != nil && change != nil {
                                                        
                                                        print("asd1 : \(string!) \(change!)")
                                                        
                                                        if change! == true {
                                                            
                                                            if let textField = output.object as? UITextField {
                                                                
                                                                print("asd2")
                                                                
                                                                let currentSearchPosition = model.originalSearchTerm.count
                                                                self.url = model.historySuggestion
                                                                
                                                                print("asd3")
                                                                
                                                                if let newCursorPosition = textField.position(from: textField.beginningOfDocument, offset: currentSearchPosition) {
                                                                    
                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                                                        textField.selectedTextRange = textField.textRange(from: newCursorPosition, to: textField.endOfDocument)
                                                                    }
                                                                    
                                                                    print("asd5")
                                                                    print("highlighting : \(newCursorPosition) - \(textField.endOfDocument)")
                                                                    
                                                                }
                                                                
                                                                
                                                            }
                                                            
                                                        } else {
                                                            
                                                            model.historySuggestion = string!
                                                            model.originalSearchTerm = self.url
                                                            self.url = model.historySuggestion
                                                            
                                                            NotificationCenter.default.post(name: UITextField.textDidChangeNotification, object: output.object)
                                                            
                                                        }
                                                        
                                                        
                                                        
                                                    }
                                                }
                                                
                                                
                                            }
                                            .onSubmit { search() }
                                            .onChange(of: self.url) { newValue in
                                                
                                                self.quickDebounceURL = newValue
                                                self.isSuggestionsLoading = true
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                    
                                                    if quickDebounceURL == newValue && self.url != "" {
                                                        
                                                        let url = URL(string: self.url)
                                                        
                                                        if url == nil {
                                                            getGoogleSearchSuggestions()
                                                        }
                                                        
                                                        url?.isReachable(completion: { success in
                                                            
                                                            // Only show google search suggestions for natural language querys
                                                            
                                                            if !success {
                                                                getGoogleSearchSuggestions()
                                                            }
                                                            
                                                        })
                                                        
                                                        
                                                        
                                                        
                                                    }
                                                    
                                                }
                                                
                                                
                                                
                                            }
                                        
                                        GeometryReader { geo in
                                            
                                            HStack {
                                                
                                                AsyncImage(url: URL(string: FavIcon(model.webViews[model.currentWorkspaceIndex].webviews[model.currentTabIndex].url != nil ? model.webViews[model.currentWorkspaceIndex].webviews[model.currentTabIndex].url!.absoluteString : model.urlString)[.l])) { image in
                                                    
                                                    image
                                                        .resizable()
                                                        .frame(width: 25, height: 25, alignment: .center)
                                                        .cornerRadius(5)
                                                    
                                                } placeholder: {
                                                    
                                                }
                                                
                                                
                                                Text(model.webViews[model.currentWorkspaceIndex].webviews[model.currentTabIndex].title ?? "")
                                                    .multilineTextAlignment(.center)
                                                    .onTapGesture {
                                                        self.isSearchFocused = true
                                                    }
                                                
                                            }
                                            .frame(width: geo.size.width, height: 40, alignment: .center)
                                            
                                        }
                                        .frame(height: 40, alignment: .center)
                                        .opacity(isSearchFocused ? 0 : 1)
                                        
                                    }
                                    .onChange(of: isSearchFocused) { newValue in
                                        if newValue == true && self.isFullSearchShowing == false {
                                            withAnimation(.easeInOut(duration: 0.25)) {
                                                self.isFullSearchShowing = true
                                                self.isMenuShowing = true
                                            }
                                        } else {
                                            if newValue == true && self.isMenuShowing == true {
                                                withAnimation(.easeInOut(duration: 0.25)) {
                                                    self.isMenuShowing = false
                                                }
                                            } else {
                                                if newValue == false && self.isMenuShowing == false {
                                                    withAnimation(.easeInOut(duration: 0.25)) {
                                                        self.isMenuShowing = true
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .onReceive(NotificationCenter.default.publisher(for: Notification.Name("newTabAdded"))) { _ in
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            self.isSearchFocused = true
                                        }
                                    }
                                    .onReceive(isScrollingDown) { (output) in
                                        
                                        let isScrollingDown = output.userInfo?["isScrollingDown"] as? Bool ?? false
                                        
                                        if isScrollingDown == true && self.isFullSearchShowing == true {
                                            withAnimation(.easeInOut(duration: 0.25)) {
                                                self.isFullSearchShowing = false
                                                self.isMenuShowing = false
                                            }
                                        }
                                        
                                        if isScrollingDown == false && self.isFullSearchShowing == false {
                                            withAnimation(.easeInOut(duration: 0.25)) {
                                                self.isFullSearchShowing = true
                                                self.isMenuShowing = true
                                            }
                                        }
                                    }
                                    .onChange(of: model.webViews[model.currentWorkspaceIndex].webviews[model.currentTabIndex].url) { newValue in
                                        
                                        if newValue != nil {
                                            
                                            if newValue!.absoluteString.hasPrefix("https://www.google.com/search?q") {
                                                var searchTerm = newValue!.absoluteString
                                                for _ in 0..<32 {
                                                    searchTerm.removeFirst()
                                                }
                                                let finalSearchTermString = searchTerm.replacingOccurrences(of: "%20", with: " ", options: .literal, range: nil)
                                                addNewHistoryItem(url: newValue!.absoluteString, searchTerm: finalSearchTermString
                                                )
                                            } else {
                                                addNewHistoryItem(url: newValue!.absoluteString, searchTerm: "")
                                            }
                                            
                                        }
                                        
                                        DispatchQueue.main.async {
                                            self.url = newValue?.absoluteString ?? ""
                                        }
                                    }
                                    .onChange(of: model.webViews[model.currentWorkspaceIndex].webviews[model.currentTabIndex].estimatedProgress) { newValue in
                                        DispatchQueue.main.async {
                                            self.progress = newValue
                                            print("progress : \(newValue)")
                                        }
                                    }
                                    .onChange(of: model.webViews[model.currentWorkspaceIndex].webviews[model.currentTabIndex].url) { newValue in
                                        
                                        guard model.currentWorkspaceIndex < model.webViews.count && model.currentWorkspaceIndex < model.workspaces.count else {
                                            return
                                        }
                                        guard model.currentTabIndex < model.webViews[currentWorkspaceIndex].webviews.count && model.currentTabIndex < model.workspaces[currentWorkspaceIndex].browserTabs.count else {
                                            return
                                        }
                                        
                                        model.workspaces[model.currentWorkspaceIndex].browserTabs[model.currentTabIndex].url = newValue?.absoluteString ?? ""
                                        
                                        saveWorkspaces(workspaces: model.workspaces)
                                        
                                        UserDefaults.standard.set(newValue?.absoluteString, forKey: "lastURL")
                                        
                                    }

                            }
                            .padding(.horizontal, self.isFullSearchShowing ? 10 : 5)
                            
                            GeometryReader { geo in
                                
                                Rectangle()
                                    .frame(width: geo.size.width * model.estimatedProgress, height: 1, alignment: .center)
                                    .opacity(model.estimatedProgress != 1.0 ? 1 : 0)
                                
                            }
                            .frame(height: 1)
                            
                        }
                        .frame(height: self.isFullSearchShowing ? 40 : 25)
                        .animation(.interpolatingSpring(stiffness: 200, damping: 20), value: isFullSearchShowing)
                        .background(Color("accent").opacity(self.isFullSearchShowing ? 1 : 0))
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        
                        
                        // Menu
                        HStack {
                            
                            // Navigation
                            HStack(spacing: 5) {
                                
                                Button {
                                    
                                    model.back()
                                    if self.isbrowserTabSelectionShowing {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            self.isbrowserTabSelectionShowing = false
                                        }
                                    }
                                    
                                } label: {
                                    Image(systemName: "chevron.left")
                                        .font(.title2)
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .foregroundColor(.primary)
                                        .background(Color("accent"))
                                        .cornerRadius(10)
                                        .opacity(model.webViews[model.currentWorkspaceIndex].webviews[model.currentTabIndex].canGoBack ? 1 : 0.2)
                                }
                                
                                Button {
                                    
                                    model.forward()
                                    if self.isbrowserTabSelectionShowing {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            self.isbrowserTabSelectionShowing = false
                                        }
                                    }
                                    
                                } label: {
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.title2)
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .foregroundColor(.primary)
                                        .background(Color("accent"))
                                        .cornerRadius(10)
                                        .opacity(model.webViews[model.currentWorkspaceIndex].webviews[model.currentTabIndex].canGoForward ? 1 : 0.2)
                                }
                                
                            }
                            .frame(width: 105, alignment: .trailing)
                            
                            Spacer()
                            
                            Button {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    self.isFullSearchShowing = false
                                    self.isMenuShowing = false
                                }
                            } label: {
                                Image(systemName: "chevron.down")
                                    .font(.title2)
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .foregroundColor(.primary)
                                
                                
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 5) {
                                
                                Button {
                                    
                                    self.isHistoryShowing = true
                                    
                                } label: {
                                    
                                    
                                    Image(systemName: "book")
                                        .font(.title2)
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .foregroundColor(.primary)
                                        .background(Color("accent"))
                                        .cornerRadius(10)
                                    
                                }
                                .sheet(isPresented: $isHistoryShowing) {
                                    historyView(isShowing: $isHistoryShowing)
                                }
                                
                                Button {
                                    
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        isbrowserTabSelectionShowing.toggle()
                                    }
                                    
                                    
                                } label: {
                                    
                                    
                                    Text(self.currentWorkspace.emoji)
                                        .font(.title2)
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .foregroundColor(.primary)
                                        .background(Color("accent"))
                                        .cornerRadius(10)
                                    
                                }
                                
                            }
                            .frame(width: 105, alignment: .trailing)
                            
                            
                            
                        }
                        .frame(height: isMenuShowing ? 55 : 0)
                        .offset(y: isMenuShowing ? 0 : 75)
                        .opacity(isMenuShowing ? 1 : 0)
                        .animation(.interpolatingSpring(stiffness: 200, damping: 20), value: isMenuShowing)
                        .background(
                            Color("background")
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        self.isFullSearchShowing.toggle()
                                        self.isMenuShowing.toggle()
                                    }
                                }
                        )
                        .padding(.horizontal, 10)
                        
                        
                    }
                }
                
            }
            
            browserTabSelectionView(height: $height, isShowing: $isbrowserTabSelectionShowing, workspaces: $model.workspaces, currentWorkspace: $currentWorkspace, currentWorkspaceIndex: $currentWorkspaceIndex, currentbrowserTabIndex: $currentbrowserTabIndex, isJustBrowsing: $isJustBrowsing)
                .opacity(self.isbrowserTabSelectionShowing ? 1 : 0)
                .onAppear {
                    if model.workspaces.count == 0 {
                        self.isbrowserTabSelectionShowing = true
                    }
                }
            
        }
        .background(Color("background"))
        .onAppear {
            
            for i in 0..<model.webViews.count {
                for ii in 0..<model.webViews[i].webviews.count {
                    model.currentWorkspaceIndex = i
                    model.currentTabIndex = ii
                    model.urlString = model.workspaces[i].browserTabs[ii].url
                    model.loadUrl()
                }
            }
            
        }
        
    }
    
    struct searchFocusedView : View {
        
        @EnvironmentObject var model: SwiftUIWebViewModel
    
        @State var isAIResponseViewShowing : Bool = false
        
        @Binding var urlString: String
        
        @Binding var isSearchFocused : Bool
        
        var popular : [historyItem] = [
            historyItem(id: "google", urlString: "https://www.google.com/", searchTerm: "Google"),
            historyItem(id: "techcrunch", urlString: "https://techcrunch.com/", searchTerm: "Tech Crunch"),
            historyItem(id: "ycombinator", urlString: "https://www.ycombinator.com/", searchTerm: "Y Combinator"),
            historyItem(id: "stripe", urlString: "https://stripe.com/gb", searchTerm: "Stripe"),
            historyItem(id: "dropbox", urlString: "https://www.dropbox.com/", searchTerm: "Drop Box"),
            historyItem(id: "cruise", urlString: "https://getcruise.com/", searchTerm: "Cruise")

        ]
        @State var popularHeight : CGFloat = 50
        
        var body: some View {

            ScrollView {
                
                VStack(alignment: .leading) {
                    
                    Text("Popular")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("primary"))
                    
                    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
                    
                    LazyVGrid(columns: columns) {
                        
                        ForEach(0..<self.popular.count, id: \.self) { i in
                            let url = self.popular[i]
                            Button {
                                self.urlString = url.urlString
                                model.urlString = url.urlString
                                model.loadUrl()
                                self.isSearchFocused.toggle()
                            } label: {
                                GeometryReader { geo in
                                    
                                    VStack {
                                        
                                        
                                        AsyncImage(url: URL(string: FavIcon(url.urlString)[.xxl])) { image in
                                            
                                            image
                                                .resizable()
                                                .frame(width: geo.size.width * 0.75, height: geo.size.width * 0.75, alignment: .center)
                                                .background(Color.white)
                                                .cornerRadius(10)
                                                .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 3)
                                            
                                        } placeholder: {
                                            
                                        }
                                        
                                        Text(url.searchTerm)
                                            .lineLimit(1)
                                            .font(.caption)
                                            .foregroundColor(Color("primary"))
                                    }
                                    .frame(width: geo.size.width, height: geo.size.width)
                                    .cornerRadius(10)
                                    .onAppear {
                                        popularHeight = geo.size.width
                                    }
                                    
                                    
                                }
                                .frame(height: popularHeight)
                            }

                        }
                        
                    }
                    
                    Text("AI Search")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("primary"))
                        .padding(.top)
                    
                    Button {
                        model.getAIReponse(prompt: urlString)
                        self.isAIResponseViewShowing = true
                    } label: {
                        
                        VStack(spacing: 10) {
                            
                            HStack {
                                
                                Text("'\(urlString)'")
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color("primary"))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.headline)
                                    .foregroundColor(Color("primary"))
                                
                            }
                            
                            HStack {
                                
                                Image("ailogo")
                                    .font(.body)
                                    .foregroundColor(Color("primary"))
                                
                                Text("Search with OpenAI")
                                    .font(.body)
                                    .foregroundColor(Color("primary"))
                                
                                Spacer()
                                
                            }
                            .opacity(0.5)
                            
                        }
                        .padding()
                        .background(Color("accent"))
                        .cornerRadius(10)
                        .clipped()
                        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 3)
                        
                        
                    }
                    .fullScreenCover(isPresented: $isAIResponseViewShowing) {
                        AISearchView(isShowing: $isAIResponseViewShowing)
                    }
                    
                    
                    
                    
                    
                }
                .padding()
                
            }
            .background(.ultraThinMaterial)
            
        }
        
    }
    
    func getGoogleSearchSuggestions() {
        
        print("search would happen now")
        self.isSuggestionsLoading = false
        
        /*
         getSearchSuggestions(searchTerm: self.url) { suggestions in

            if suggestions != nil {
                DispatchQueue.main.async {
                    self.isSuggestionsLoading = false
                    self.searchSuggestions = suggestions!
                    print("search suggestions changed : \(self.searchSuggestions.suggestions.count)")
                }
            }

         }
         */
         
    }
    
    func search() {
        
        print("fgh sumbitted")
        let url = URL(string: self.url)
        
        if url != nil {
            
            // check if url is valid
            url?.isReachable { success in
                
                if success {
                    
                    print("fgh1")
                    // Load url
                    DispatchQueue.main.async {
                        model.urlString = self.url
                        model.loadUrl()
                    }
                    
                } else {
                    
                    let alteredURLString = "https://\(self.url)"
                    let alteredURL = URL(string: alteredURLString)
                    // check if url is valid
                    alteredURL?.isReachable { success2 in
                        
                        if success2 {
                            print("fgh2")
                            DispatchQueue.main.async {
                                model.urlString = alteredURLString
                                model.loadUrl()
                            }
                            
                        } else {
                            
                            // Search with google
                            print("fgh3")
                            
                            let newString = self.url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
                            DispatchQueue.main.async {
                                model.urlString = "https://www.google.com/search?q=\(newString)"
                                model.loadUrl()
                            }
                            
                        }
                        
                        
                    }
                }
            }
        } else {
            print("fgh3")
            
            let newString = self.url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
            DispatchQueue.main.async {
                model.urlString = "https://www.google.com/search?q=\(newString)"
                model.loadUrl()
            }
        }
    }
    
    func getSearchSuggestions(searchTerm: String, completion: @escaping ((suggestions?) -> Void))  {
            
            var urlComponents = URLComponents(string:"https://serpapi.com/search/")
            
            guard urlComponents != nil else {
                print("error creating url object")
                completion(nil)
                return
            }
            
            urlComponents?.queryItems = [
                URLQueryItem(name: "engine", value: "google_autocomplete"),
                URLQueryItem(name: "q", value: searchTerm),
                URLQueryItem(name: "api_key", value: "bec91c53e4ae80bd0b0b688082913a213e195cb2c4b05caf13815b912b6fcd89")
            ]
            
            let url = urlComponents?.url
            
            var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            
            let headers =  [
                "engine" : "google_autocomplete",
                "q" : searchTerm,
                "api_key" : "bec91c53e4ae80bd0b0b688082913a213e195cb2c4b05caf13815b912b6fcd89",
                "content-type" : "application/json"
            ]
            
            request.allHTTPHeaderFields = headers
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("something went wrong here")
                    completion(nil)
                    return
                }
                
                var suggs : suggestions?
                do {
                    suggs = try JSONDecoder().decode(suggestions.self, from: data)
                }
                catch {
                    print("failed to covert \(error)")
                    completion(nil)
                }
                completion(suggs)
                guard let json = suggs else {
                    return
                }
                
                print("json : \(json)")
                 
                
                
                
            }
            .resume()
        }
    
    struct searchSuggestion : Decodable {
        var value: String
        var relevance: Int
    }
    
    struct suggestions : Decodable {
        var suggestions : [searchSuggestion]
    }

    func addNewHistoryItem(url: String, searchTerm: String) {
        
        let item = historyItem(id: UUID().uuidString, urlString: url, searchTerm: searchTerm)
        model.history.insert(item, at: 0)
        
        if let encoded = try? JSONEncoder().encode(model.history) {
            UserDefaults.standard.set(encoded, forKey: "history")
        }
        
    }
    
    func getHistorySuggestions(searchTerm : String, completion: @escaping ((String?, Bool?) -> Void)) {
        
        if model.historySuggestion != self.url {
            
            if searchTerm != model.originalSearchTerm && model.originalSearchTerm.hasPrefix(searchTerm) == false {
                
                print("890 \(model.historySuggestion) : \(self.url) : \(model.originalSearchTerm)")
                model.historySuggestion = ""
                
                if searchTerm.count > 1 {
                    
                    let firstWhere = model.history.first { history in
                        history.searchTerm.contains(searchTerm)
                    }
                    
                    if firstWhere != nil {
                        
                        var suggestion = firstWhere!.searchTerm
                        let subRange = suggestion.ranges(of: searchTerm)
                        if subRange.count != 0 {
                            let sub = subRange[0].lowerBound
                            let range = suggestion.startIndex..<sub
                            suggestion.removeSubrange(range)
                        }
                        
                        
                        completion(suggestion, false)
                        
                        
                    } else {
                        
                        let firstWhere2 = model.history.first { history in
                            history.urlString.contains(searchTerm)
                        }
                        
                        if firstWhere2 != nil {
                            
                            var suggestion = firstWhere2!.urlString
                            let subRange = suggestion.ranges(of: searchTerm)
                            if subRange.count != 0 {
                                let sub = subRange[0].lowerBound
                                let range = suggestion.startIndex..<sub
                                suggestion.removeSubrange(range)
                            }
                            
                            
                            completion(suggestion, false)
                        }
                        
                        
                        
                    }
                    
                }
                
            }
            
        } else {
            
            completion("", true)
            
        }
        
        
        
    }
    
        
}

// MARK: - Data Structures
struct historyItem : Identifiable, Codable {
    
    var id: String = ""
    var urlString: String = ""
    var searchTerm: String = ""
    var date: Date = Date.now
    
}

struct workspace : Identifiable, Codable {
    
    var id: String = ""
    var name: String = ""
    var emoji: String = ""
    var browserTabs : [browserTab] = []
    
}

struct browserTab : Identifiable, Codable {
    
    var id: String = ""
    var url: String = ""
    var title : String = ""
    
    var isLocked : Bool = false
    var isChangingTitle : Bool = false
}

// MARK: - Views
struct historyView : View {
    
    @EnvironmentObject var model: SwiftUIWebViewModel
    
    @Binding var isShowing: Bool
    
    @State private var showingAlert = false
    
    var body: some View {
        
        
        VStack {
            
            HStack {
                
                Text("History")
                    
                    .bold()
                
                Spacer()
                
                Button {
                    
                    showingAlert = true
                    
                } label: {
                    Text("Clear History")
                        .foregroundColor(.red)
                }
                .alert("Clear All Browser History", isPresented: $showingAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Confirm", role: .destructive) {
                        UserDefaults.standard.set(nil, forKey: "history")
                        DispatchQueue.main.async {
                            model.history = []
                        }
                    }
                }

                
            }
            .padding()
            
            ScrollView {
                
                LazyVStack(spacing: 0) {
                    
                    ForEach(0..<model.history.count, id: \.self) { i in
                        
                        let historyItem = model.history[i]
                        
                        
                        
                        Button {
                            
                            model.urlString = historyItem.urlString
                            model.loadUrl()
                            self.isShowing = false
                            
                        } label: {
                            
                            HStack {
                                
                                if historyItem.urlString != "" {
                                    AsyncImage(url: URL(string: FavIcon(historyItem.urlString)[.l])) { image in
                                        
                                        image
                                            .resizable()
                                            .frame(width: 25, height: 25, alignment: .center)
                                            .cornerRadius(5)
                                        
                                    } placeholder: {
                                        
                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    
                                    Text(historyItem.searchTerm != "" ? historyItem.searchTerm : historyItem.urlString)
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                        .lineLimit(1)
                                    
                                    Text("\(historyItem.date)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                    
                                }
                                
                                Spacer()
                                
                                
                            }
                            .padding(.vertical)
                            
                            
                        }
                        
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.primary.opacity(0.1))
                        
                    }
                    
                }
                .padding(.horizontal)
                
            }
            
        }
        .background(Color("background"))
        
    }
    
}

struct createNewbrowserTabView : View {
    
    @EnvironmentObject var model: SwiftUIWebViewModel
    
    @Binding var isShowing : Bool
    
    @Binding var workspaces: [workspace]
    @Binding var currentWorkspaceIndex: Int
    
    @State var emojiSelection : String = ""

    var emojiOptions: [String] = ["🔥", "🚀", "📚", "💪🏻", "💬", "🤝", "🦄", "😂", "👀", "💸", "📈", "🏳️‍🌈"]
    
    @State var workspaceName : String = ""
    @FocusState var isFocused : Bool
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.75)
                .onTapGesture {
                    self.isShowing = false
                }
            
            VStack(alignment: .center, spacing : 25) {
                
                TextField("Name Your Workspace", text: $workspaceName)
                    .textInputAutocapitalization(.words)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 10)
                    .focused($isFocused)
                    .frame(height: 40)
                    .background(Color("accent"))
                    .cornerRadius(10)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            self.isFocused = true
                        }
                    }
                
                let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
                
                LazyVGrid(columns: columns) {
                    
                    ForEach(0..<self.emojiOptions.count, id: \.self) { i in
                        let emoji = self.emojiOptions[i]
                        
                        Button {
                            withAnimation(.easeInOut) {
                                self.emojiSelection = emoji
                            }
                        } label: {
                            ZStack {
                                
                                Rectangle()
                                    .foregroundColor(self.emojiSelection == emoji ? Color("selected") : Color("accent"))
                                
                                Text(emoji)
                                    .foregroundColor(.primary)
                                    .font(.title)
                                    .padding()
                            }
                            .cornerRadius(10)
                        }

                    }
                    
                }
                
                
                Button {
                    // Add New Workspace
                    if self.emojiSelection != "" && self.workspaceName != ""  {
                        addWorkspace()
                    }
                    
                } label: {
                    
                    HStack {
                        
                        Spacer()
                        
                        Text("Add Workspace")
                            .bold()
                            .foregroundColor(Color("background"))
                        
                        Spacer()
                        
                    }
                    .padding()
                    .background(self.emojiSelection != "" && self.workspaceName != "" ? .primary : Color("accent"))
                    .cornerRadius(10)
  
                    
                }

                
            }
            .padding()
            .background(Color("background"))
            .cornerRadius(10)
            .padding()
        }
        
        
    }
    
    func addWorkspace() {
        
        let uuid = UUID().uuidString
        let workspace = workspace(id: uuid, name: self.workspaceName, emoji: self.emojiSelection, browserTabs: [])

        model.webViews.append(workspaceWebviewModel(id: uuid, webviews: []))
        self.workspaces.append(workspace)
        self.currentWorkspaceIndex = self.workspaces.count - 1
        self.isShowing = false
        saveWorkspaces(workspaces: model.workspaces)
        
    }
    
}

struct browserTabSelectionView : View {
    
    @EnvironmentObject var model: SwiftUIWebViewModel
    
    @Namespace private var animation
    
    @Binding var height : CGFloat
    
    @Binding var isShowing : Bool
    
    @Binding var workspaces : [workspace]
    @Binding var currentWorkspace : workspace
    
    @Binding var currentWorkspaceIndex : Int
    @Binding var currentbrowserTabIndex : Int
    
    @State var isCreateNewWorkspaceShowing : Bool = false
    
    @Binding var isJustBrowsing : Bool
    
    var body: some View {
        
        ZStack {
            
            if model.workspaces.count != 0 {
                
                
                VStack(spacing: 5) {
                    
                    HStack {
                        
                        newSigmaLogo(color: .primary, isTransition: false, isAnimated4: Binding.constant(false), isAnimated6: Binding.constant(false), isAnimated7: Binding.constant(true))
                            .opacity(0)
                            .frame(width: 35, height: 35, alignment: .center)
                        
                        Spacer()
                        
                        Text("Workspaces")
                            .font(.system(size: 24).weight(.heavy))
                        
                        
                        Spacer()
                        
                        Button {
                            
                            isCreateNewWorkspaceShowing = true
                            
                        } label: {
                            
                            Image(systemName: "plus")
                                .font(.title3)
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(.primary)
                                .background(Color("background"))
                                .cornerRadius(10)
                            
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    
                    ScrollView {
                        
                        
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        LazyHStack {
                            
                            ForEach(0..<workspaces.count, id: \.self) { i in
                                let workspace = workspaces[i]
                                
                                Button {
                                    
                                    withAnimation {
                                        self.currentWorkspaceIndex = i
                                    }
                                    
                                } label: {
                                    
                                    VStack(spacing: 2) {
                                        
                                        Text(workspace.emoji)
                                            .font(.title2)
                                            .foregroundColor(.primary)
                                        
                                        if currentWorkspaceIndex == i {
                                            Rectangle()
                                                .frame(width: 15, height: 2)
                                                .cornerRadius(10)
                                                .matchedGeometryEffect(id: "selection", in: animation)
                                                .foregroundColor(.primary)
                                        }
                                        
                                        Text(workspace.name)
                                            .font(.caption)
                                            .foregroundColor(.primary)
                                            .lineLimit(1)
                                        
                                    }
                                    .frame(width: 75, height: 60, alignment: .center)
                                    .opacity(currentWorkspaceIndex == i ? 1 : 0.3)
                                    .animation(.interpolatingSpring(stiffness: 200, damping: 20), value: currentWorkspaceIndex == i)
                                    
                                }

                            }
                        }
                        .padding(.horizontal)
                        .frame(height: 60)
                    }
                    .frame(height: 60)
                    
                    ZStack {
                                                
                        ForEach(0..<workspaces.count, id: \.self) { i in
                            
                            let workspace = $workspaces[i]
                            
                            workspaceView(workspaceIndex: i, isShowing: $isShowing, workspace: workspace, currentWorkspace: $currentWorkspace, currentWorkspaceIndex: $currentWorkspaceIndex, currentbrowserTabIndex: $currentbrowserTabIndex, height: $height)
                                .opacity(i == currentWorkspaceIndex ? 1 : 0)
                                .tag(i)
                        }
                        
                    }
                    .frame(height: self.height + 50)
                    .padding(.top)
                        
                    }
                    
                    
                    HStack {
                        
                        Button {
                            addNewbrowserTab()
                        } label: {
                            Image(systemName: "plus")
                                .font(.title3)
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(.primary)
                                .background(Color("background"))
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        Menu {
                            Button(role: .destructive) {
                                deleteWorkspace()
                            } label: {
                                Label("Delete Workspace", systemImage: "trash")
                            }

                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.title3)
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(.primary)
                                .background(Color("background"))
                                .cornerRadius(10)
                        }


                        
                        
                    }
                    .padding()
                    .background(Color("background"))
                    
                }
                
                
                
            } else {
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        
                        
                        Text("Welcome")
                            .font(.system(size: 35, weight: .heavy))
                        
                        
                        Text("Hey Ali, Mahyad & Saurav! \nWelcome to my SigmaOS for iPhone Prototype.")
                            .font(.body)
                            .foregroundColor(Color.primary.opacity(0.5))
                            .multilineTextAlignment(.center)
                        
                        
                    }
                    .padding()
                    
                    let features : [String] = ["custom1", "Organise Tabs Into Workspaces", "Intuitive Navigation & Design"]
                    /*
                     TabView {
                     
                     ForEach(0..<features.count, id: \.self) { i in
                     
                     let feature = features[i]
                     
                     VStack {
                     
                     HStack(alignment: .firstTextBaseline) {
                     
                     Spacer()
                     
                     if feature == "custom1" {
                     
                     HStack(alignment: .firstTextBaseline, spacing: 0) {
                     Text("Fight your tabs, ")
                     .font(.body)
                     .strikethrough()
                     
                     Text("love your tabs 🧡")
                     .font(.body)
                     .lineLimit(1)
                     }
                     
                     } else {
                     
                     Text(feature)
                     .font(.body)
                     .lineLimit(1)
                     }
                     
                     Spacer()
                     
                     }
                     .padding()
                     .background(Color("accent"))
                     .cornerRadius(10)
                     
                     Spacer()
                     
                     }
                     .padding()
                     
                     
                     }
                     
                     }
                     .frame(height: 125)
                     .tabViewStyle(.page)
                     .indexViewStyle(.page(backgroundDisplayMode: .always))
                     .padding(.bottom, 50)
                     */
                    
                    
                    VStack(spacing: 25) {
                        
                        Button {
                            
                            self.isCreateNewWorkspaceShowing = true
                            
                        } label: {
                            
                            HStack {
                                
                                Spacer()
                                
                                Text("Create First Workspace")
                                    .font(.headline)
                                    .foregroundColor(Color("background"))
                                
                                Spacer()
                                
                            }
                            .padding()
                            
                            .background(.primary)
                            .cornerRadius(10)
                            
                        }
                        
                        
                        HStack {
                            
                            Text("or")
                                .font(.body)
                            
                            Button {
                                
                                let uuid = UUID().uuidString
                                let workspace = workspace(id: uuid, name: "Just Browsing", emoji: "🤟", browserTabs: [browserTab(id: uuid, url: "https://google.com/", title: "Just Browsing", isLocked: false, isChangingTitle: false)])
                                model.workspaces = [workspace]
                                currentWorkspace = workspace
                                
                                let ws = workspaceWebviewModel(id: uuid, webviews: [WKWebView()])
                                model.webViews = [ws]
                                
                                model.currentWorkspaceIndex = 0
                                model.currentTabIndex = 0
                                
                                isShowing = false
                                model.urlString = "https://google.com/"
                                model.loadUrl()
                            } label: {
                                Text("just browse")
                                    .font(.body.bold())
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    .padding()
                    
                    
                    Spacer()
                    
                    
                }
                .background(Color("accent"))
                .cornerRadius(10)
                
            }
            
        }
        .background(.ultraThinMaterial)
        .fullScreenCover(isPresented: $isCreateNewWorkspaceShowing) {
            createNewbrowserTabView(isShowing: $isCreateNewWorkspaceShowing, workspaces: $workspaces, currentWorkspaceIndex: $currentWorkspaceIndex)
                .background(BackgroundBlurView()
                    .onTapGesture {
                        isCreateNewWorkspaceShowing = false
                    }
                )
        }
        
    }
    

                
                
                func addNewbrowserTab() {
                    let uuid = UUID().uuidString
                    let browserTabb = browserTab(id: uuid, url: "https://google.com/")
                    model.webViews[currentWorkspaceIndex].webviews.append(WKWebView())
                    model.urlString = browserTabb.url
                    model.currentWorkspaceIndex = currentWorkspaceIndex
                    print("currentWorkspaceIndex \(model.currentWorkspaceIndex)")
                    model.currentTabIndex = model.webViews[currentWorkspaceIndex].webviews.count - 1
                    print("pol \(model.currentWorkspaceIndex) : \(model.currentTabIndex)")
                    model.currentTab = browserTabb
                    self.currentWorkspace = self.workspaces[currentWorkspaceIndex]
                    self.workspaces[currentWorkspaceIndex].browserTabs.append(browserTabb)
                    self.isShowing = false
                    saveWorkspaces(workspaces: model.workspaces)
                    model.loadUrl()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newTabAdded"),
                                                    object: nil)
                    
                }
                
                func deleteWorkspace() {
                    for i in 0..<model.workspaces.count {
                        let w = model.workspaces[i]
                        if w.id == self.workspaces[currentWorkspaceIndex].id {
                            currentWorkspaceIndex = 0
                            model.workspaces.remove(at: i)
                            saveWorkspaces(workspaces: model.workspaces)
                            break
                            
                        }
                    }
                    
                }
                
                struct cornerPiece: Shape {
                    func path(in rect: CGRect) -> Path {
                        var path = Path()
                        
                        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                        path.addLine(to: CGPoint(x: rect.maxY, y: rect.maxY))
                        
                        path.addCurve(to: CGPoint(x: rect.minX, y: rect.minY), control1: CGPoint(x: rect.minX * 0.1, y: rect.maxY), control2: CGPoint(x: rect.minX, y: rect.maxY * 0.1))
                        
                        
                        return path
                    }
                }
                
            }

struct workspaceView : View {
    
    @EnvironmentObject var model: SwiftUIWebViewModel
    
    var workspaceIndex: Int
    
    @Binding var isShowing: Bool
    
    @Binding var workspace : workspace
    @Binding var currentWorkspace : workspace
    
    @Binding var currentWorkspaceIndex : Int
    @Binding var currentbrowserTabIndex : Int
    
    @Binding var height : CGFloat
    
    @State var isChangeTabNameShowing : Bool = false
    @State var changeTabNameString : String = ""
    @State var currentChangeTab : browserTab = browserTab()
    
    var body: some View {
        
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        
        VStack {
            
            let isSelected = workspaceIndex == currentWorkspaceIndex

            
            GeometryReader { geo in
                
                let cellWidth = (geo.size.width - 5) / 2
                let cellHeight = cellWidth * 1.2
                
                LazyVGrid(columns: columns) {
 
                    ForEach(self.workspace.browserTabs) { browserTabb in
                        
                        //let browserTabb = self.workspace.browserTabs[i]
                        let urll = browserTabb.url

                        let index = self.workspace.browserTabs.firstIndex { b in
                            b.id == browserTabb.id
                        }

                            VStack(spacing: 0) {
                                
                                ZStack(alignment: .topTrailing) {
                                    

                                    Button {
                                        
                                        let url = URL(string: urll)
                                        
                                        if url != nil {
                                            
                                            DispatchQueue.main.async {
                                                
                                                model.urlString = urll
                                                model.currentWorkspaceIndex = workspaceIndex
                                                model.currentTabIndex = index ?? 0
                                                print("model.currentTabIndex = \(model.currentTabIndex)")
                                                if model.webViews[workspaceIndex].webviews[index ?? 0].url == nil {
                                                    model.loadUrl()
                                                }
                                                self.isShowing = false
                                                self.currentWorkspace = workspace
                                                markCurrentTab(tabb: browserTabb)
                                                UserDefaults.standard.set(workspaceIndex, forKey: "currentWorkspaceIndex")
                                                UserDefaults.standard.set(model.currentTabIndex, forKey: "currentbrowserTabIndex")
                                            }
                                            
                                        }
                                    } label: {
                                        
                                        ZStack {
                                            let i = index ?? 0
                                            if i < model.webViews[workspaceIndex].webviews.count {
                                                
                                                let urlll = URL(string: urll)
                                                if urlll != nil {
                                                    WebSelectionCell(url: urlll!)
                                                        .frame(width: cellWidth * 2, height: cellHeight * 2, alignment: .center)
                                                        .scaleEffect(0.5)
                                                        .disabled(true)
                                                    
                                                    
                                                } else {
                                                    Text("url : \(urll)")
                                                }
                                            }
                                        }
                                        .frame(width: cellWidth, height: cellHeight, alignment: .center)

                                        
                                    }
                                    .frame(width: cellWidth, height: cellHeight, alignment: .center)
                                    

                                    Menu {
                                        
                                        Button(role: .none) {
                                                
                                                if browserTabb.title != "" {
                                                    self.changeTabNameString = browserTabb.title
                                                } else {
                                                    self.changeTabNameString = urll
                                                }
                                                
                                                self.currentChangeTab = browserTabb
                                            
                                                self.isChangeTabNameShowing = true
                                            
                                            
                                        } label: {
                                            Label("Change Tab Name", systemImage: "pencil.line")
                                        }
                                        
                                        if browserTabb.isLocked {
                                            
                                            Button(role: .none) {
                                                
                                                for i in 0..<self.workspace.browserTabs.count {
                                                    let tabb = self.workspace.browserTabs[i]
                                                    if tabb.id == browserTabb.id {
                                                        self.workspace.browserTabs[i].isLocked.toggle()
                                                        break
                                                    }
                                                }
                                                
                                            } label: {
                                                Label("Unlock", systemImage: "lock.fill")
                                            }
                                        } else {
                                            Button(role: .none) {
                                                
                                                for i in 0..<self.workspace.browserTabs.count {
                                                    let tabb = self.workspace.browserTabs[i]
                                                    if tabb.id == browserTabb.id {
                                                        self.workspace.browserTabs[i].isLocked.toggle()
                                                        break
                                                    }
                                                }
                                                
                                            } label: {
                                                Label("Lock", systemImage: "lock.open")
                                            }
                                            
                                        }
                                        if browserTabb.isLocked == false {
                                            
                                            Button(role: .destructive) {
                                                deletebrowserTab(browserTab: browserTabb)
                                            } label: {
                                                Label("Delete Workspace", systemImage: "xmark")
                                            }
                                        }
                                        
                                    } label: {
                                        
                                        Image(systemName: "ellipsis")
                                            .font(.body)
                                            .frame(width: 25, height: 25, alignment: .center)
                                            .foregroundColor(.primary)
                                            .background(Color("background"))
                                            .cornerRadius(10)
                                            .clipped()
                                            .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: -3)

                                        
                                    }
                                    .padding(10)
                                    
                                }
                                
                                HStack {
                                    
                                    Spacer()
                                    

                                    
                                    AsyncImage(url: URL(string: FavIcon(urll)[.xxl])) { image in
                                        
                                        image
                                            .resizable()
                                            .frame(width: 17, height: 17, alignment: .center)
                                        
                                    } placeholder: {
                                        
                                    }
                                    
                                    
                                    Text(browserTabb.title != "" ? browserTabb.title : urll)
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                        .lineLimit(1)

                                    
                                    
                                    Spacer()
                                    
                                }

                                .padding(10)
                                .background(Color("background"))
                                .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: -3)
                                
                                
                            }
                            .frame(width: cellWidth, alignment: .center)
                            .cornerRadius(10)
                            .clipped()
                            .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.primary, style: StrokeStyle(lineWidth : 1))
                                    .opacity(model.currentTab.id == browserTabb.id ? 1 : 0)
                            )
                            .scaleEffect(isShowing ? 1 : 0.1)
                            .opacity(isShowing ? 1 : 0)
                            .animation(.interpolatingSpring(stiffness: 200, damping: Double(15)), value: isShowing)
                            .scaleEffect(isSelected ? 1 : 0.1)
                            .animation(.interpolatingSpring(stiffness: 200, damping: Double(15)), value: isSelected)
                            .transition(.scale.combined(with: .opacity).animation(.interpolatingSpring(stiffness: 200, damping: 15)))
                        
                    }
                    
                }
                .onAppear {
                    
                    if workspace.browserTabs.count != 0 {
                        var rows = Double(self.workspace.browserTabs.count + 1) / 2.0
                        rows.round(.up)
                        print("rows : \(rows)")
                        self.height = cellHeight * 1.2 * rows
                    }
                }
                .onChange(of: self.workspace.browserTabs.count) { newValue in
                    var rows = Double(self.workspace.browserTabs.count + 1) / 2.0
                    rows.round(.up)
                    print("rows : \(rows)")
                    self.height = cellHeight * 1.2 * rows
                }
                .onChange(of: self.currentWorkspaceIndex) { v in
                    if currentWorkspaceIndex == workspaceIndex {
                        var rows = Double(self.workspace.browserTabs.count + 1) / 2.0
                        rows.round(.up)
                        print("rows : \(rows)")
                        self.height = cellHeight * 1.2 * rows
                    }
                }
                
                
            }
            .frame(height: height)
            
            Spacer()
            
            
        }
        .padding()
        .sheet(isPresented: $isChangeTabNameShowing) {
            changeTabNameView(isShowing: $isChangeTabNameShowing, title: self.changeTabNameString, tabs: self.$workspace.browserTabs, tab: currentChangeTab)
        }
        
    }
    
    func markCurrentTab(tabb: browserTab) {
        
        model.currentTab = tabb
        
        for i in 0..<self.workspace.browserTabs.count {
            let tab = self.workspace.browserTabs[i]
            if tab.id == tabb.id {
                self.currentWorkspaceIndex = workspaceIndex
                self.currentbrowserTabIndex = i
                break
            }
        }
        
        
    }
    
    func deletebrowserTab(browserTab: browserTab) {
        
        for i in 0..<self.workspace.browserTabs.count {
            let t = self.workspace.browserTabs[i]
            if t.id == browserTab.id {
                model.webViews[workspaceIndex].webviews.remove(at: i)
                self.workspace.browserTabs.remove(at: i)
                saveWorkspaces(workspaces: model.workspaces)
                break
            }
        }
    }
    
    struct changeTabNameView : View {
        
        @EnvironmentObject var model: SwiftUIWebViewModel
        
        @Binding var isShowing : Bool
        
        @State var title : String = ""
        
        @Binding var tabs : [browserTab]
        var tab : browserTab
        
        @FocusState var isFocused : Bool
        
        var body: some View {
            
            VStack {
                
                Text("Rename Tab")
                    .font(.title2)
                    .bold()
                
                TextField("Enter Tab Name", text: $title)
                    .submitLabel(.done)
                    .onSubmit {
                        if self.title != "" {
                            for i in 0..<self.tabs.count {
                                let tabb = self.tabs[i]
                                if tabb.id == tab.id {
                                    self.tabs[i].title = title
                                    self.isShowing = false
                                    saveWorkspaces(workspaces: model.workspaces)
                                    break
                                }
                            }
                        }
                    }
                    .focused($isFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            self.isFocused = true
                        }
                    }
                    .padding(10)
                    .background(Color("accent"))
                    .cornerRadius(10)
                
                Button {
                    
                    if self.title != "" {
                        for i in 0..<self.tabs.count {
                            let tabb = self.tabs[i]
                            if tabb.id == tab.id {
                                self.tabs[i].title = title
                                self.isShowing = false
                                saveWorkspaces(workspaces: model.workspaces)
                                break
                            }
                        }
                    }
                    
                } label: {
                    
                    HStack {
                        
                        Spacer()
                        
                        Text("Done")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                    }
                    .padding()
                    .background(Color("orange"))
                    .cornerRadius(10)
                    .opacity(self.title != "" ? 1 : 0.25)
                }

                
            }
            .padding()
            
        }
        
    }
    
}

struct FavIcon {
    enum Size: Int, CaseIterable { case s = 16, m = 32, l = 64, xl = 128, xxl = 256, xxxl = 512 }
    private let domain: String
    init(_ domain: String) { self.domain = domain }
    subscript(_ size: Size) -> String {
        "https://www.google.com/s2/favicons?sz=\(size.rawValue)&domain=\(domain)"
    }
}

// MARK: - Functions

func saveWorkspaces(workspaces: [workspace]) {
    if let encoded = try? JSONEncoder().encode(workspaces) {
        UserDefaults.standard.set(encoded, forKey: "savedWorkspaces")
    }
}

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

// MARK: - UIViews

struct clearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct WebSelectionCell : UIViewRepresentable {
    
    var url: URL
     
        func makeUIView(context: Context) -> WKWebView {
            return WKWebView()
        }
     
        func updateUIView(_ webView: WKWebView, context: Context) {
            
            url.isReachable { success in
                
                if success {
                    
                    print("yui")
                    let request = URLRequest(url: url)
                    DispatchQueue.main.async {
                        webView.load(request)
                        webView.scrollView.isScrollEnabled = false
                    }
                    
                    
                } else {
                    print("yui2")
                    // Search with google
                    let newString = url.absoluteString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
                    let newURL = "https://www.google.com/search?q=\(newString)"
                    let request = URLRequest(url: URL(string: newURL)!)
                    DispatchQueue.main.async {
                        webView.load(request)
                        webView.scrollView.isScrollEnabled = false
                        
                    }
                    
                    
                }
                
                
            }
        }
    
}

struct WebView: UIViewRepresentable {
 
    typealias UIViewType = WKWebView
        
    @Binding var webView: WKWebView
        
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Model

final class SwiftUIWebViewModel: ObservableObject {
    
    let scrollViewDelegate = MyScrollViewDelegate()
    
    @Published var workspaces: [workspace] = []
    
    @Published var prompt: String = ""
    @Published var response: String = ""
    @Published var isReponseLoading: Bool = false

    @Published var urlString = "https://www.google.com/"
    @Published var estimatedProgress : Double = 1.0
    
    @Published var hasScrollingHiddenMenu: Bool = false
    @Published var currenScrollPosition: CGFloat = 0
    

    @Published var webViews: [workspaceWebviewModel]
    @Published var currentWorkspaceIndex: Int = 0
    @Published var currentTabIndex: Int = 0
    
    @Published var history: [historyItem] = []
    @Published var historySuggestion: String = ""
    @Published var originalSearchTerm: String = ""
    
    @Published var currentTab: browserTab = browserTab()
    
    @State var timer : Timer?
    
    init() {
        

        self.webViews = [workspaceWebviewModel]()

        
        let url =  UserDefaults.standard.string(forKey: "lastURL")
        if url == nil {
            print("cant find lastURL")
        } else {
            let lastURL = UserDefaults.standard.string(forKey: "lastURL")
            self.urlString = lastURL!
            print("lastURL : \(lastURL!)")
        }
        
        if let data = UserDefaults.standard.data(forKey: "savedWorkspaces") {
            if let decoded = try? JSONDecoder().decode([workspace].self, from: data) {
                workspaces = decoded
                
                var webViews : [workspaceWebviewModel] = []
                for i in 0..<decoded.count {
                    let workspace = decoded[i]
                    var ws = workspaceWebviewModel(id: workspace.id, webviews: [])
                    
                    for _ in 0..<workspace.browserTabs.count {
                        
                        var tab = WKWebView(frame: .zero)
                        scrollViewDelegate.webView = tab
                        tab.scrollView.delegate = scrollViewDelegate
                        ws.webviews.append(tab)
                    }
                    webViews.append(ws)
                    
                }
                self.webViews = webViews
            }
        }
        
        if let data = UserDefaults.standard.data(forKey: "history") {
            if let decoded = try? JSONDecoder().decode([historyItem].self, from: data) {
                let sorted = decoded.sorted { h1, h2 in
                    h1.date > h2.date
                }
                self.history = sorted
                return
            }
        }
    }
    
    func loadUrl() {

        
        guard let url = URL(string: urlString) else {
            return
        }
        guard self.currentWorkspaceIndex < webViews.count && self.currentWorkspaceIndex < workspaces.count else {
            return
        }
        guard self.currentTabIndex < webViews[currentWorkspaceIndex].webviews.count && self.currentTabIndex < workspaces[currentWorkspaceIndex].browserTabs.count else {
            return
        }
        
        self.webViews[self.currentWorkspaceIndex].webviews[self.currentTabIndex].load(URLRequest(url: url))
        self.workspaces[self.currentWorkspaceIndex].browserTabs[self.currentTabIndex].url = urlString
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
            
            guard self.currentWorkspaceIndex < self.webViews.count else {
                self.timer?.invalidate()
                return
            }
            guard self.currentTabIndex < self.webViews[self.currentWorkspaceIndex].webviews.count else {
                self.timer?.invalidate()
                return
            }
            withAnimation(.easeInOut) {
                self.estimatedProgress = self.webViews[self.currentWorkspaceIndex].webviews[self.currentTabIndex].estimatedProgress
            }
            if self.webViews[self.currentWorkspaceIndex].webviews[self.currentTabIndex].estimatedProgress == 1.0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.estimatedProgress = 0.0
                }
                self.timer?.invalidate()
            }
        }
        
        if let encoded = try? JSONEncoder().encode(workspaces) {
            UserDefaults.standard.set(encoded, forKey: "savedWorkspaces")
        }
        
        
        UserDefaults.standard.set(url.absoluteString, forKey: "lastURL")
        
        if UserDefaults.standard.string(forKey: "lastURL")!.isEmpty {
            print("isEmpty")
        } else {
            print("userDefualt Set")
        }
        
        
    }
    

    func getAIReponse(prompt: String) {
        
        self.response = ""
        self.prompt = prompt
        isReponseLoading = true
        APICaller.shared.getResponse(input: prompt) { result in
            print("1")
            switch result {
                
            case .success(let output):
                print("sucess : \(output)")
                DispatchQueue.main.async {
                    self.response = output
                    self.isReponseLoading = false
                }
                
            case .failure(_):
                print("failure")
                self.isReponseLoading = false
                
            }
            
        }
    }

    
    func back() {
        webViews[self.currentWorkspaceIndex].webviews[self.currentTabIndex].goBack()
    }
    
    func forward() {
        webViews[self.currentWorkspaceIndex].webviews[self.currentTabIndex].goForward()
    }
}

struct workspaceWebviewModel {
    
    var id : String
    var webviews : [WKWebView]
    
}

// MARK: - Extensions

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

class MyScrollViewDelegate: NSObject {
    weak var webView: WKWebView?
    var currentScroll : CGFloat = 0
}

extension MyScrollViewDelegate: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //printLocation(for: scrollView, label: "will begin dragging")
        let y = scrollView.panGestureRecognizer.location(in: webView).y
        self.currentScroll = y
    }

    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        //printLocation(for: scrollView, label: "will end dragging")
        let y = scrollView.panGestureRecognizer.location(in: webView).y
        self.currentScroll = y
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isTracking {
            printLocation(for: scrollView, label: "is tracking")
        }
    }
    
    private func printLocation(for scrollView: UIScrollView, label: String) {
        if let webView = webView {
            
            let y = scrollView.panGestureRecognizer.location(in: webView).y
            let velocity = scrollView.panGestureRecognizer.velocity(in: webView).y
            print("velocity : \(abs(velocity))")
            
            if currentScroll != 0 {
                
                if y - currentScroll > 50 {
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "isScrollingDown"),
                                                    object: nil, userInfo: ["isScrollingDown" : false])
                    print("pol \(y) > \(currentScroll)")
                    self.currentScroll = y
                    return
                }
                
                if currentScroll - y > 50 {
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "isScrollingDown"),
                                                    object: nil, userInfo: ["isScrollingDown" : true])
                    print("pol \(y) < \(currentScroll)")
                    self.currentScroll = y
                    return
                }
                
            } else {
                
                currentScroll = y
                
            }
        }
    }
}
