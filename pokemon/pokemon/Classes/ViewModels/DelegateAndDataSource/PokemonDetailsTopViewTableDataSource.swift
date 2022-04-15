//
//  PokemonDetailsTopViewTableDataSource.swift
//  pokemon
//
//  Created by Márcio Duarte on 15/04/2022.
//

import Foundation
import UIKit

class PokemonDetailsTopViewTableDataSource<CELL : UITableViewCell, T>: NSObject, UITableViewDataSource, UITableViewDelegate {

    private var cellIdentifier: String!
    private var newPokemonDetails: [Any]!
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
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonDetailsCellTableViewCell.identifier, for: indexPath) as! CELL

        if let pokemonDetails = self.newPokemonDetails as? [PokemonDetails] {
            self.configureCell(cell, pokemonDetails[indexPath.row])
        }
        
        return cell
    }
}