//
//  MapButton.swift
//  vadmitrievaPW7
//
//  Created by Varvara on 26.01.2022.
//

import UIKit

final class MapButton: UIButton {
    
    init(color: UIColor, text: String){
        super.init(frame: .zero)
        self.backgroundColor = color
        setTitle(text, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
