package mies

class TipoGrupo implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'tpgr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpgr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpgr__id'
            descripcion column: 'tpgrdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..127, blank: true, nullable: true, attributes: [mensaje: 'Descripción del tipo de grupo de atención del SENPLADES'])
    }

    String toString() {
        return this.descripcion
    }
}