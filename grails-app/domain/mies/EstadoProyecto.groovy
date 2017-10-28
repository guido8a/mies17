package mies

class EstadoProyecto implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'edpy'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'edpy__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'edpy__id'
            descripcion column: 'edpydscr'
        }
    }
    static constraints = {
        descripcion(size: 1..31, blank: false, attributes: [mensaje: 'Descripción del Estado del proyecto'])
    }

    String toString() {
        return this.descripcion
    }
}