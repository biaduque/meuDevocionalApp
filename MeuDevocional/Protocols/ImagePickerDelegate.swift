//
//  ImagePickerDelegate.swift
//  MeuDevocional
//
//  Created by Beatriz Duque on 11/02/22.
//

import UIKit

public protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?)
}
