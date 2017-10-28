package mies

class TipoProcedencia implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'tppc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tppc__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tppc__id'
            descripcion column: 'tppcdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..31, blank: false, attributes: [mensaje: 'Descripción del tipo de procedencia'])
    }
    String toString(){
        "${this.descripcion}"
    }
}