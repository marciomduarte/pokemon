//
//  PokemonDetailsTopViewTableDataSource.swift
//  pokemon
//
//  Created by Márcio Duarte on 15/04/2022.
//
// Class with the delegates and data source of the table view used to shown the details of the pokemons selected

import Foundation
import UIKit

class PokemonDetailsTopViewTableDataSource<CELL : UITableViewCell, T>: NSObject, UITableViewDataSource, UITableViewDelegate {

    /// Identifier of the cell used on tableView
    private var cellIdentifier: String!

    /// Var with details of pokemons to present
    private var newPokemonDetails: [Any]!

    /// Configuration of the cell that will be returned to the
    var configureCell: (CELL, PokemonDetails) -> () = {_,_ in}

    override init() {
        super.init()
    }

    init(cellIdentifier: String, pokemonDetails: [T], startCellConfiguration: @escaping (CELL, Any) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.newPokemonDetails = pokemonDetails
        self.configureCell = startCellConfiguration
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newPokemonDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonDetailsCell.identifier, for: indexPath) as! CELL

        if let pokemonDetails = self.newPokemonDetails as? [PokemonDetails] {
            self.configureCell(cell, pokemonDetails[indexPath.row])
        }
        
        return cell
    }
}
