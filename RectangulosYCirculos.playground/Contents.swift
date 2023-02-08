import UIKit

var greeting = "Hello, playground"

protocol Figuras {
    var base: Double? { get set }
    var altura: Double? { get set }
    var diametro: Double? { get set }
}

struct Rectangulo: Figuras {
    var base: Double?
    var altura: Double?
    var diametro: Double?
}

struct Circulo: Figuras {
    var altura: Double?
    var diametro: Double?
    var base: Double?
}

var starArray: [Figuras] = [Rectangulo(base: 2, altura: 3), Circulo(diametro: 2.8), Circulo(diametro: 3.1), Rectangulo(base: 3, altura: 3.5), Circulo(diametro: 3.4)]

var endArray: [Figuras] = []

func setSortedArray() {
    let helperArray: [Circulo] = starArray.map { figura -> Circulo in
        if let base = figura.base,
           let altura = figura.altura {
            let diametro = (base * altura) / 2
            return Circulo(diametro: diametro)
        } else {
            return Circulo(diametro: figura.diametro)
        }
    }
    endArray = helperArray.sorted { $0.diametro ?? 0.0 < $1.diametro ?? 0.0}
    
    endArray.map { figura in
        print(figura.diametro ?? 0.0)
    }
}

setSortedArray()
