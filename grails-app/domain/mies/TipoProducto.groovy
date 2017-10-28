package mies

class TipoProducto implements Serializable {
    String tipoProducto
    static auditable = [ignore: []]
    static mapping = {
        table 'tppd'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tppd__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tppd__id'
            tipoProducto column: 'tppddscr'
        }
    }
    static constraints = {
        tipoProducto(size: 1..31, blank: false, attributes: [mensaje: 'Descripción del tipo de producto'])
    }

    String toString() {
        return this.tipoProducto
    }
}