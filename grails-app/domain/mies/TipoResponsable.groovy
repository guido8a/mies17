package mies

class TipoResponsable implements Serializable {

    String codigo
    String descripcion

    static auditable = [ignore: []]
    static mapping = {
        table 'tprp'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tprp__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tprp__id'
            codigo: 'tprpcdgo'
            descripcion column: 'tprpdscr'
        }
    }
    static constraints = {
        codigo(size: 1..1, blank: false, nullable: false, attributes: [mensaje: 'Código del tipo de responsable'])
        descripcion(size: 1..15, blank: false, attributes: [mensaje: 'Descripción del ripo de responsable'])
    }

    String toString() {
        "${this.descripcion}"
    }
}