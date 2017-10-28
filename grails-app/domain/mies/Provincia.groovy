package mies

class Provincia implements Serializable {
    Zona zona
    Region region
    Integer numero
    String nombre
    String nombreMostrar
    String coords
    String imagen

    String codigo

    static auditable = [ignore: []]
    static mapping = {
        table 'prov'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prov__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'prov__id'
            zona column: 'zona__id'
            region column: 'regn__id'
            numero column: 'provnmro'
            nombre column: 'provnmbr'
            nombreMostrar column: 'provnmms'
            coords column: 'provcrds'
            imagen column: 'provimgn'

            codigo column: 'provcdgo'
        }
    }
    static constraints = {
        zona(blank: true, nullable: true, attributes: [mensaje: 'Zona a la que pertenece la provincia'])
        region(blank: true, nullable: true, attributes: [mensaje: 'Región a la que pertenece la provincia'])
        numero(blank: true, nullable: true, attributes: [mensaje: 'Número de la provincia'])
        nombre(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Nombre de la provincia'])
        nombreMostrar(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Nombre de la provincia como se va a ver en el mapa'])
        coords(maxSize: 5000, blank: true, nullable: true, attributes: [mensaje: 'Coordenadas para el map'])
        imagen(maxSize: 1024, blank: true, nullable: true, attributes: [mensaje: 'Nombre del archivo del mapa de la provincia'])
        codigo(maxSize: 4, blank: true, nullable: true, attributes: [mensaje: 'Código de la provincia'])
    }

    String toString() {
        return this.nombre
    }
}