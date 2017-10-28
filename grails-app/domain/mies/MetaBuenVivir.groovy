package mies

class MetaBuenVivir implements Serializable {
    PoliticaBuenVivir politica
    Integer codigo
    String descripcion
    static auditable = [ignore: []]
    static mapping = {
        table 'mtbv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'mtbv__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'mtbv__id'
            politica column: 'plbv__id'
            codigo column: 'mtbvcdgo'
            descripcion column: 'mtbvdscr'
        }
    }
    static constraints = {
        politica(blank: false, nullable: false, attributes: [mensaje: 'Meta del buen vivir'])
        codigo(blank: false, nullable: false, attributes: [mensaje: 'Código de la meta'])
        descripcion(size: 1..127, blank: true, nullable: true, attributes: [mensaje: 'Descripción de la meta'])
    }

    String toString() {
        return this.politica.objetivo.codigo + "." + this.politica.codigo + "." + this.codigo + " - " + this.descripcion
    }
}
