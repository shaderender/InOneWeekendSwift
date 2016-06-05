import Foundation

func hitSphere(center: vec3, radius: Float, r: ray) -> Bool {
    
    let oc = r.origin - center
    let a = dot(r.direction, r.direction)
    let b = 2 * dot(oc, r.direction)
    let c = dot(oc, oc) - radius * radius
    let discriminant = b * b - 4 * a * c
    
    return discriminant > 0
}

func color(r: ray) -> vec3 {
    
    if hitSphere(vec3(0, 0, -1), radius: 0.5, r: r) {
        return vec3(1, 0, 0)
    }
    
    let unitDirection = r.direction.unitVector()
    let t = 0.5 * (unitDirection.y + 1.0)
    return (1.0 - t) * vec3(1, 1, 1) + t * vec3(0.5, 0.7, 1.0)
}


// MARK: - Main
let nx = 200
let ny = 100

print("P3\n\(nx) \(ny)\n255\n")

let lowerLeftCorner = vec3(-2, -1, -1)
let horizontal = vec3(4, 0, 0)
let vertical = vec3(0, 2, 0)
let origin = vec3(0, 0, 0)

for j in (0..<ny).reverse() {
    for i in 0..<nx {
        
        let u = Float(i) / Float(nx)
        let v = Float(j) / Float(ny)
        
        let r = ray(origin, lowerLeftCorner + u * horizontal + v * vertical)
        let col = color(r)
        
        let ir = Int(255.99 * col.r)
        let ig = Int(255.99 * col.g)
        let ib = Int(255.99 * col.b)
        
        print("\(ir) \(ig) \(ib)")
    }
}