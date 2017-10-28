package mies

class Distrito implements Serializable {
    String codigo
    String nombre
    static auditable = [ignore: []]
    static mapping = {
        table 'dstt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dstt__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dstt__id'
            codigo column: 'dsttcdgo'
            nombre column: 'dsttnmbr'
        }
    }
    static constraints = {
        codigo(size: 1..5, blank: true, nullable: true, attributes: [mensaje: 'Código del distrito'])
        nombre(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Nombre del distrito'])
    }
    String toString() {
        return this.nombre
    }
}