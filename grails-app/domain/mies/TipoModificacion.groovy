package mies

class TipoModificacion implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'tpmd'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpmd__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpmd__id'
            descripcion column: 'tpmddscr'
        }
    }
    static constraints = {
        descripcion(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Descripción del tipo de modificación'])
    }
}