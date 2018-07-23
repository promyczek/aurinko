//
//  StubData.swift
//  aurinko
//
//  Created by Ania on 22/07/2018.
//  Copyright © 2018 Ania. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class StubData {
    
    class func populateData() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate,
            storeIsEmpty(delegate: delegate) else {
            return
        }
        
        insertCategories(delegate: delegate)
        insertQuotes(delegate: delegate)
    }
    
    class func storeIsEmpty(delegate: AppDelegate) -> Bool {
        do {
            let context = delegate.persistentContainer.viewContext
            let categories = try context.fetch(QuoteCategory.fetchRequest())
            let quotes = try context.fetch(Quote.fetchRequest())
            if categories.isEmpty, quotes.isEmpty {
                return true
            } else {
                return false
            }
        }
        catch {
            print("Fetching Quote Categories Failed")
        }
        return false
    }
    
    class func insertCategories(delegate: AppDelegate) {
        let context = delegate.persistentContainer.viewContext
        
        let category = QuoteCategory(context: context)
        category.name = "Moje dziecko"
        category.id = 0
        
        delegate.saveContext()
    }
    
    class func insertQuotes(delegate: AppDelegate) {
        let context = delegate.persistentContainer.viewContext
        var category: QuoteCategory? = nil
        
        do {
            let categories = try context.fetch(QuoteCategory.fetchRequest())
            category = categories.first as? QuoteCategory
        }
        catch {
            print("Fetching Quote Categories Failed")
        }
        
        let quotes = ["Ponieważ zostałeś stworzony na mój obraz (Rodzaju 1.27)",
                      "We mnie żyjesz, poruszasz się i jesteś (Dzieje Apostolskie 17.28)",
                      "Bo jesteś moim potomstwem (Dzieje Apostolskie 17.28)",
                      "Znałem Cię zanim zostałeś poczęty (Jeremiasz 1.4-5)",
                      "Wybrałem Ciebie gdy planowałem stworzenie (Efezjan 1.11-12)",
                      "Nie byłeś pomyłką (Psalm 139.15)",
                      "Wszystkie Twoje dni są zapisane w mojej księdze (Psalm 139.16)",
                      "Określiłem dokładny czas Twojego urodzenia i miejsce zamieszkania (Dzieje Apostolskie 17.26)",
                      "Jesteś cudownie stworzony (Psalm 139.14)",
                      "Ukształtowałem Cię w łonie Twojej matki (Psalm 139.13)",
                      "I byłem pomocny w dniu twoich narodzin (Psalm 71.6)",
                      "Jestem fałszywie przedstawiany przez tych, którzy mnie nie znają (Jan 8.41-44)",
                      "Nie jestem odległy i gniewny, jestem pełnią miłości (1 Jana 4.16)",
                      "I całym sercem pragnę Cię tą miłością obdarzyć (1 Jana 3.1)",
                      "Daję Ci więcej niż Twój ziemski ojciec mógłby Ci zapewnić (Mateusz 7.11)",
                      "Bo jestem Ojcem doskonałym (Mateusz 5.48)",
                      "Wszelkie dobro, jakie otrzymujesz, pochodzi z mojej ręki (Jakub 1.17)",
                      "Zaopatruję cię i zaspokajam wszystkie Twoje potrzeby (Mateusz 6,31-33)",
                      "Moim planem jest dać ci dobrą przyszłość (Jeremiasz 29,11)",
                      "Ponieważ kocham Cię miłością wieczną i nieskończoną (Jeremiasz 31.3)",
                      "Moich myśli o Tobie jest więcej niż ziaren piasku na brzegu morza… (Psalm 139.17-18)",
                      "I cieszę się Tobą, śpiewając z radości (Sofoniasz 3.17)",
                      "Nigdy nie przestanę czynić Ci dobra (Jeremiasz 32.40)",
                      "Gdyż jesteś moją drogocenną własnością (Wyjścia 19.5)",
                      "Z całego serca i z całej duszy chcę, byś mieszkał bezpiecznie (Jeremiasz 32.41)",
                      "I pokazać Ci rzeczy wielkie i wspaniałe (Jeremiasz 33.3)",
                      "Jeśli będziesz mnie szukał z całego serca, znajdziesz mnie (Powtórzonego Prawa 4.29)",
                      "Rozkoszuj się mną, a dam Ci to, czego pragnie Twoje serce (Psalm 37.4)",
                      "Bo to Ja daję Ci takie pragnienia (Filipian 2.13)",
                      "Jestem w stanie dać ci o wiele więcej, niż możesz sobie wyobrazić (Efezjan 3.20)",
                      "To we mnie znajdziesz największe wsparcie i zachętę (2 Tesaloniczan 2.16-17)",
                      "Jestem też Ojcem, który pociesza Cię we wszelkich twoich smutkach (2 Koryntian 1.3-4)",
                      "Kiedy jesteś załamany, jestem blisko Ciebie (Psalm 34.18)",
                      "Tak jak pasterz niosący owieczkę, trzymam Cię blisko mojego serca (Izajasz 40.11)",
                      "Pewnego dnia otrę wszystkie łzy z Twoich oczu (Objawienie 21.3-4)",
                      "I uwolnię od wszelkiego bólu, który znosiłeś na ziemi (Objawienie 21.3-4)",
                      "Jestem Twoim Ojcem i kocham Cię dokładnie tak, jak kocham mojego syna, Jezusa (Jan 17.23)",
                      "Bo w Jezusie objawiłem moją miłość do Ciebie (Jan 17.26)",
                      "Jezus umarł żebyśmy – Ty i ja – mogli zostać pojednani (2 Koryntian 5.18-19)",
                      "Oddałem wszystko co kochałem, by zdobyć Twoją miłość (Rzymian 8.31-32)",
                      "Jeśli przyjmiesz dar mojego syna Jezusa, przyjmiesz mnie samego (1 Jana 2.23)",
                      "I nic już nigdy nie oddzieli Cię od mojej miłości (Rzymian 8.38-39)",
                      "Przyjdź do mnie, a wyprawię największą ucztę, jaką niebo kiedykolwiek widziało (Łukasz 15.7)",
                      "Zawsze byłem Ojcem i zawsze Nim będę (Efezjan 3.14-15)",
                      "Ale czy Ty… “chcesz być moim dzieckiem?” (Jan 1.12-13)",
                      "Czekam na Ciebie (Łukasz 15.11-32)"
                    ]
        
        for item in quotes {
            let quote = Quote(context: context)
            quote.text = item
            quote.category = category
            quote.id = Int16(quotes.index(of: item)!.hashValue)
            delegate.saveContext()
        }
    }
    
}
