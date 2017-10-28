package mies

class ObjetivoGobiernoResultado implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'obgr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'obgr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'obgr__id'
            descripcion column: 'obgrdscr'
        }
    }
    static constraints = {
        descripcion(blank: false, nullable: false, attributes: [mensaje: 'Descripción'])
    }
}