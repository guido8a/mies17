package mies

class TipoAdquisicion implements Serializable {
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'tpaq'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpaq__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpaq__id'
            descripcion column: 'tpaqdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..31, blank: false, attributes: [mensaje: 'Descripción del tipo de adquisición'])
    }
}