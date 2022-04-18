# PokemonDemo App

An iOS application that retrieves and shows Pokémon information from an external API.

## Desenvolvimento

- Application developed using xCode 13.2.1
- Application developed using Swift 5 
- MVVM architecture
- API used: PokeAPI (https://pokeapi.co/).

## WebServives

- PokemonEndpointString: Responsable to create the url with parameters received.
- PokemonWebService: Responsable for the communication between the application and the API.

## Classes

- PokemonListViewController
- PokemonDetailsViewController

## View

- PokemonListView
- PokemonDetailsBottomView
- PokemonDetailsTopView

## ViewModels and Delegate And Data Source

### ViewModels

- PokemonListViewModel
- PokemonDetailsViewModel
- PokemonDetailsTopViewModel

### Delegate and Data Source

- PokemonListDataSource
- PokemonDetailsTopViewTableDataSource

## Model

- Pokemon
- PokemonList
- PokemonDetails

## Custom UI

- PokemonCell
- PokemonDetailsCell

## Extensions

- UIViewController
- UIApplication
- UIWindow
- UIView
- URLSession
- UILabel
- UIFont
- UIColor

## Utilities

- PokemonUtils
- Constants

## Data Retrieved

### Pokemon

- Id
- Name
- Front Default Picture
- Back Default Picture
- Height
- Weight
- Type(s)
- Abilities
- Stats

### Other data

- Count
- Previous
- Next

## Tests

### UnitTests

- pokemonUILabelTests
- pokemonUIViewTests
- pokemonUIFontTests
- pokemonAPIServicesTests

### UITests

- pokemonListANdDetailsTests

## TODO List

- [x] iPhone Support
- [x] iPad full support
- [x] Fetch Pokemons from API
- [x] Allow dependency injection
- [x] Pagination
- [x] Support multiple device orientation
- [x] Add app icon
- [x] Set app launch screen
- [x] Accessibility
- [x] Add UITesting
- [x] Add UnitTesting
- [x] Show loading on last cell when the app wait for the service response
- [x] Search pokemon by ID
- [x] Search pokemon by Name
- [x] Show Pokémon Height information
- [x] Show Pokémon Weight information
- [x] Show Pokémon Abilities Information
- [x] Show Pokémon Basic Stat Information
- [x] Show Pokémon Type(s) information
- [x] Show Pokémon front and back image
- [x] Swipe between Pokémon details (previous and next)
- [] Save favorite Pokémons
- [] Show Pokémon moves information
- [] Add custom loading animation 
- [] Add custom popup
