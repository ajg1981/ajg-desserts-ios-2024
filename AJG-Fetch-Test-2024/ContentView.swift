//
//  ContentView.swift
//  AJG-Fetch-Test-2024
//
//  Created by user264552 on 7/5/24.
//

import SwiftUI

struct Response: Codable {
    var meals: [RecipeItem]
    
    struct RecipeItem: Codable {
        var strMeal: String
        var strMealThumb: String
        var idMeal: String
    }
}

struct ContentView: View {
    @State private var results = [Response.RecipeItem]()
    @State var idMeal = ""
    
    func loadData() async {
        guard let url = URL( string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert" ) else {
            print( "Invalid URL" )
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data( from: url )
            
            if let decodedResponse = try? JSONDecoder().decode( Response.self, from: data ) {
                results = decodedResponse.meals
            }
        } catch {
            print( "Invalid data" )
        }
    }
    
    var body: some View {
        NavigationStack {
            List( results, id: \.idMeal ) { item in
                VStack() {
                    Button( action:{
                        
                    }, label: {
                        Text( item.strMeal )
                        AsyncImage( url: URL( string: item.strMealThumb ) ) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame( width:300, height: 300 )
                        
                    }).background(
                        NavigationLink( destination: DetailView( idMeal:item.idMeal ) ) {}
                    ).padding()
                }
            }.task {
                await loadData()
            }
        }
    }
}

#Preview {
    ContentView()
}
