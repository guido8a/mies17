package mies

class ProgramaPresupuestario implements Serializable {
    String codigo
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'pgps'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'pgps__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'pgps__id'
            codigo column: 'pgpscdgo'
            descripcion column: 'pgpsdscr'
        }
    }
    static constraints = {
        codigo(size: 1..20, blank: true, nullable: true, attributes: [mensaje: 'Código del programa presupuestario'])
        descripcion(size: 1..255, blank: true, nullable: true, attributes: [mensaje: 'Descripción corta del programa presupuestario'])
    }

    String toString() {
        "${this.codigo}:${this.descripcion}"
    }
}