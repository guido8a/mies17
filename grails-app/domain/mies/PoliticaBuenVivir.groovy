package mies

class PoliticaBuenVivir implements Serializable {
    ObjetivoBuenVivir objetivo
    Integer codigo
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'plbv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'plbv__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'plbv__id'
            objetivo column: 'obbv__id'
            codigo column: 'plbvcdgo'
            descripcion column: 'plbvdscr'
        }
    }
    static constraints = {
        objetivo(blank: false, nullable: false, attributes: [mensaje: 'Objetivo cel buen vivir'])
        codigo(blank: false, nullable: false, attributes: [mensaje: 'Código de la política'])
        descripcion(size: 1..510, blank: true, nullable: true, attributes: [mensaje: 'Descripción de la política'])
    }

    String toString() {
        return this.objetivo.codigo + "." + this.codigo + " - " + this.descripcion
    }
}