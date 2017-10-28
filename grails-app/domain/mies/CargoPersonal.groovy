package mies

class CargoPersonal implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'cgpr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cgpr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'cgpr__id'
            descripcion column: 'cgprdscr'
        }
    }
    static constraints = {
        descripcion(matches: /^[a-zA-Z0-9ñÑ .,áéíóúÁÉÍÚÓüÜ#_-]+$/, size: 1..63, blank: false, attributes: ["mensaje": "Descripción del cargo del personal"])
    }

    String toString() {
        "${this.descripcion}"
    }
}