package mies

class TipoElemento implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'tpel'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpel__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpel__id'
            descripcion column: 'tpeldscr'
        }
    }
    static constraints = {
        descripcion(size: 1..15, blank: true, nullable: true, attributes: [mensaje: 'Descripción del tipo de elemento'])
    }
}