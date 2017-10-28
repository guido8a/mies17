package mies

class Region implements Serializable {
    String codigo
    String nombre
    static auditable = [ignore: []]
    static mapping = {
        table 'regn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'regn__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'regn__id'
            codigo column: 'regncdgo'
            nombre column: 'regnnmbr'
        }
    }
    static constraints = {
        codigo(size: 1..1, blank: true, nullable: true, attributes: [mensaje: 'Código de la región'])
        nombre(size: 1..15, blank: true, nullable: true, attributes: [mensaje: 'Nombre de la región'])
    }

    String toString() {
        return this.nombre
    }
}