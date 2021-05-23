import Foundation


func generateMockNewsData() -> LocalNews {
    var localNews: LocalNews = LocalNews()
    localNews.name = "USA Tech News"
    localNews.date = Int(Date().currentTimeMillis())
    
    
    var a1 = Article()
    a1.title = "Apple's battle with Fortnite could change the iPhone as we know it"
    a1.content = "Sherlock and Watson, peanut butter and jelly, Netflix and chill. Since 2008, Apple has created that sort of inextricable link between its iPhones and its App Store. The company's \"there\'s an app for that\" ad campaign drew millions of people, who over the years have bought more than a billion iPhones. And since the App Store was the only place to get programs for the iPhone, millions of developers flocked to Apple too. Now the tech giant is facing questions about whether it\'s running a monopoly, forced into the topic by Fortnite maker Epic Games and Epic\'s lawsuit alleging an abuse of power."
    a1.image = "https://www.verdict.co.uk/wp-content/uploads/2020/08/fortnite-google-apple.jpg"
    a1.date = Int(Date().currentTimeMillis() - (1000 * 60 * 60 * 1))
    localNews.articles.append(a1)
    
    
    var a2 = Article()
    a2.title = "Apple charged over 'anti-competitive' app policies"
    a2.content = "European Commission anti-trust regulator Margrethe Vestager tweeted that \"consumers are losing out\". It relates to charges brought two years ago by music streaming app Spotify which claimed that Apple was stifling innovation in that industry. Apple faces a large fine and may be forced to change its policies if its arguments do not convince regulators."
    a2.image = "https://ichef.bbci.co.uk/news/976/cpsprodpb/85EF/production/_118278243_screenshot.png"
    a2.date = Int(Date().currentTimeMillis() - (1000 * 60 * 60 * 2))
    localNews.articles.append(a2)
    
    
    var a3 = Article()
    a3.title = "NASA and SpaceX's $2.9 Billion USD Contract Suspended Following Protests From Jeff Bezos' Blue Origin"
    a3.content = "NASA and SpaceX's $2.9 Billion USD Contract Suspended Following Protests From Jeff Bezos' Blue Origin"
    a3.image = ""
    a3.date = Int(Date().currentTimeMillis() - (1000 * 60 * 60 * 3))
    localNews.articles.append(a3)
    
    var a4 = Article()
    a4.title = "NASA and SpaceX's $2.9 Billion USD Contract Suspended Following Protests From Jeff Bezos' Blue Origin"
    a4.content = "14 years after Calibri took over from Times New Roman as the operating system’s default font, the tech giant is finally looking to change things up with a new set. To do so, it commissioned a team of designers who came up with five new custom, original fonts named Tenorite, Bierstadt, Skeena, Seaford and Grandview. All five offer unique and refreshing takes on what makes a good, standard font, and Microsoft is now inviting the Internet to help them choose the best one."
    a4.image = "https://www.ivory.co.il/files/catalog/org/1612249423w23Nj.jpg"
    a4.date = Int(Date().currentTimeMillis() - (1000 * 60 * 60 * 4))
    localNews.articles.append(a4)
    
//    var a5 = Article()
//    a5.title = ""
//    a5.content = ""
//    a5.image = ""
//    a5.date = Int(Date().currentTimeMillis() - (1000 * 60 * 60 * 5))
//    localNews.articles.append(a5)
//    
//    var a6 = Article()
//    a6.title = ""
//    a6.content = ""
//    a6.image = ""
//    a6.date = Int(Date().currentTimeMillis() - (1000 * 60 * 60 * 6))
//    localNews.articles.append(a6)
    
    return localNews
}
