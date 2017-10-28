package mies

class ObjetivoEstrategicoProyecto implements Serializable {
    Integer orden
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'obes'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'obes__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'obes__id'
            orden column: 'obesordn'
            descripcion column: 'obesdscr'
        }
    }
    static constraints = {
        orden(blank: false, nullable: false, attributes: [mensaje: 'Orden'])
        descripcion(blank: false, nullable: false, attributes: [mensaje: 'Descripción del objetivo'])
    }

    String toString() {
        return this.descripcion
    }
}