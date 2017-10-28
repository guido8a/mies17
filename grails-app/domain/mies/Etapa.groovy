package mies

class Etapa implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'etpa'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'etpa__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'etpa__id'
            descripcion column: 'etpadscr'
        }
    }
    static constraints = {
        descripcion(size: 1..31, blank: false, attributes: [mensaje: 'Descripción de la etapa del proyecto'])
    }

    String toString() {
        return this.descripcion
    }
}