package mies

class Fase implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'fase'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'fase__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'fase__id'
            descripcion column: 'fasedscr'
        }
    }
    static constraints = {
        descripcion(size: 1..31, blank: false, attributes: [mensaje: 'Descripción de la fase del proyecto'])
    }

    String toString() {
        return this.descripcion
    }
}