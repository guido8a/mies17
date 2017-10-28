package mies

class Zona implements Serializable {
    Integer numero
    String nombre
    static auditable = [ignore: []]
    static mapping = {
        table 'zona'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'zona__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'zona__id'
            numero column: 'zonanmro'
            nombre column: 'zonanmbr'
        }
    }
    static constraints = {
        numero(blank: true, nullable: true, attributes: [mensaje: 'Número de la zona'])
        nombre(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Nombre de la zona'])
    }
    String toString() {
        return this.nombre
    }
}