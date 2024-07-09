import SwiftUI
import WebKit

struct DetailResponse: Codable {
    var meals: [DetailItem]
    
    struct DetailItem: Codable {
        var idMeal: String? = ""
        var strMeal: String? = ""
        var strDrinkAlternate: String? = ""
        var strCategory: String? = ""
        var strArea: String? = ""
        var strInstructions: String? = ""
        var strMealThumb: String? = ""
        var strTags: String? = ""
        var strYoutube: String? = ""
        var strIngredient1: String? = ""
        var strIngredient2: String? = ""
        var strIngredient3: String? = ""
        var strIngredient4: String? = ""
        var strIngredient5: String? = ""
        var strIngredient6: String? = ""
        var strIngredient7: String? = ""
        var strIngredient8: String? = ""
        var strIngredient9: String? = ""
        var strIngredient10: String? = ""
        var strIngredient11: String? = ""
        var strIngredient12: String? = ""
        var strIngredient13: String? = ""
        var strIngredient14: String? = ""
        var strIngredient15: String? = ""
        var strIngredient16: String? = ""
        var strIngredient17: String? = ""
        var strIngredient18: String? = ""
        var strIngredient19: String? = ""
        var strIngredient20: String? = ""
        var strMeasure1: String? = ""
        var strMeasure2: String? = ""
        var strMeasure3: String? = ""
        var strMeasure4: String? = ""
        var strMeasure5: String? = ""
        var strMeasure6: String? = ""
        var strMeasure7: String? = ""
        var strMeasure8: String? = ""
        var strMeasure9: String? = ""
        var strMeasure10: String? = ""
        var strMeasure11: String? = ""
        var strMeasure12: String? = ""
        var strMeasure13: String? = ""
        var strMeasure14: String? = ""
        var strMeasure15: String? = ""
        var strMeasure16: String? = ""
        var strMeasure17: String? = ""
        var strMeasure18: String? = ""
        var strMeasure19: String? = ""
        var strMeasure20: String? = ""
        var strSource: String? = ""
        var strImageSource: String? = ""
        var strCreativeCommonsConfirmed: String? = ""
        var dateModified: String? = ""
    }
}

struct DetailView: View {
    @State private var detailResults = [DetailResponse.DetailItem]()
    var idMeal:String
    
    func loadDetailData() async {
        guard let url = URL( string: "https://themealdb.com/api/json/v1/1/lookup.php?i=" + idMeal ) else {
            print( "Invalid URL" )
            return
        }
        
        do {
            let ( data, _ ) = try await URLSession.shared.data( from: url )
            
            if let decodedResponse = try? JSONDecoder().decode(DetailResponse.self, from: data ) {
                detailResults = decodedResponse.meals
            }
        } catch {
            print( "Invalid data" )
        }
    }
    
    func concatStringsForIngred( ingredStr:String? = "", measureStr:String? = "" ) -> Text? {
        var ingredConcatString:String = ""
        if ingredStr != nil && ingredStr != "" {
            if measureStr != nil && measureStr != "" {
                ingredConcatString += measureStr! + " "
            }
            ingredConcatString += ingredStr!
        } else {
            return nil
        }
        return Text(ingredConcatString).italic()
    }
    
    var body: some View {
        List( detailResults, id: \.idMeal ) { item in
            VStack {
                Text( item.strMeal ?? "" ).font( .system( size:30 ) )
                
                if item.strMealThumb != nil && item.strMealThumb != "" {
                    AsyncImage( url: URL( string: item.strMealThumb! ) ) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame( width:300, height: 300 )
                }
                
                Text( item.strTags ?? "" ).bold()
                Text( item.strDrinkAlternate ?? "" )
                Text( item.strCategory ?? "" ).bold()
                Text( item.strArea ?? "" ).italic()
                
                Text( "\n INGREDIENTS" ).bold()
                concatStringsForIngred( ingredStr: item.strIngredient1, measureStr: item.strMeasure1 )
                concatStringsForIngred( ingredStr: item.strIngredient2, measureStr: item.strMeasure2 )
                concatStringsForIngred( ingredStr: item.strIngredient3, measureStr: item.strMeasure3 )
                concatStringsForIngred( ingredStr: item.strIngredient4, measureStr: item.strMeasure4 )
                concatStringsForIngred( ingredStr: item.strIngredient5, measureStr: item.strMeasure5 )
                concatStringsForIngred( ingredStr: item.strIngredient6, measureStr: item.strMeasure6 )
                concatStringsForIngred( ingredStr: item.strIngredient7, measureStr: item.strMeasure7 )
                concatStringsForIngred( ingredStr: item.strIngredient8, measureStr: item.strMeasure8 )
                concatStringsForIngred( ingredStr: item.strIngredient9, measureStr: item.strMeasure9 )
                concatStringsForIngred( ingredStr: item.strIngredient10, measureStr: item.strMeasure10 )
                concatStringsForIngred( ingredStr: item.strIngredient11, measureStr: item.strMeasure11 )
                concatStringsForIngred( ingredStr: item.strIngredient12, measureStr: item.strMeasure12 )
                concatStringsForIngred( ingredStr: item.strIngredient13, measureStr: item.strMeasure13 )
                concatStringsForIngred( ingredStr: item.strIngredient14, measureStr: item.strMeasure14 )
                concatStringsForIngred( ingredStr: item.strIngredient15, measureStr: item.strMeasure15 )
                concatStringsForIngred( ingredStr: item.strIngredient16, measureStr: item.strMeasure16 )
                concatStringsForIngred( ingredStr: item.strIngredient17, measureStr: item.strMeasure17 )
                concatStringsForIngred( ingredStr: item.strIngredient18, measureStr: item.strMeasure18 )
                concatStringsForIngred( ingredStr: item.strIngredient19, measureStr: item.strMeasure19 )
                concatStringsForIngred( ingredStr: item.strIngredient20, measureStr: item.strMeasure20 )
                
                Text( "\n" + ( item.strInstructions ?? "" ) ).fixedSize( horizontal: false, vertical: true )
                
                if item.strYoutube != nil && item.strYoutube != "" {
                    ScrollView {
                        WebView( url: URL( string:item.strYoutube! )! )
                            .frame( height:300 )
                    }
                }
                
                if item.strSource != nil && item.strSource != "" {
                    Link( "Source: " + item.strSource!, destination: URL(string: item.strSource! )! )
                }
                
                Text( item.strImageSource ?? "" )
                Text( item.strTags ?? "" ).bold()
                Text( item.strCreativeCommonsConfirmed ?? "" )
                Text( item.dateModified ?? "" )
            }
           .frame( width:300 )
        }.task {
            await loadDetailData()
        }
    }
}
