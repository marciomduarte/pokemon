# PokemonDemo App

An iOS application that retrieves and shows Pokémon information. This app use an an external API to get the pokemons and your additional information.

## Desenvolvimento

- Application developed using xCode 13.2.1
- Application developed using Swift 5 
- MVVM architecture
- API used: PokeAPI (https://pokeapi.co/).

## WebServives

- PokemonEndpointString: Responsable to create the url with parameters received.
- PokemonWebService: Responsable for the communication between the application and the API.

## Classes

- PokemonListViewController: First screen. Showns the pokemon list in collection view. Each cell have the color corresponding to the type of pokemon, name, id. It has a search bar that allows the user to search for a pokemon by id or by name. When one of the cells is pressed, the app automatically go to detail of pokemon
- PokemondetailsViewController: Show the details of the pokemons. On this screen, the user can see the front or back image of the pokemon. You can also see its general details (Height, weight, ...), abilities and base stats. This screen also has an option to switch from pokemon through with a swipe(left or right)

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

- PokemonListDataSource: Data source and delegate for the list of pokemons. Used on PokemonListViewController UICollectionView
- PokemonDetailsTopViewTableDataSource: Data source and delegate for the details of pokemon. Used on POkemonDetailsTopView UITableView

## Model

- Pokemon
- PokemonList
- PokemonDetails

## Custom UI

- PokemonCell: Cell with configuration to present the pokemon information. Used in the PokemonListViewController UICollectionView  
- PokemonDetailsCell: Cell with configuration to present the details of the pokemon. Used in the PokemonDetailsTopView UITableView

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

- [x] iPhone full Support
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
- [ ] Hide search bar when scrolling collection view
- [ ] Save favorite Pokémons
- [ ] Show Pokémon moves information
- [ ] Add custom loading animation 
- [ ] Add custom popup
- [ ] Add animation when user click on pokemon to get more detail
