package mies

class MetaBuenVivirProyecto implements Serializable {
    Proyecto proyecto
    MetaBuenVivir metaBuenVivir
    static auditable = [ignore: []]
    static mapping = {
        table 'mtpy'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'mtpy__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'mtpy__id'
            proyecto column: 'proy__id'
            metaBuenVivir column: 'mtbv__id'
        }
    }
    static constraints = {
        proyecto(blank: false, nullable: false, attributes: [mensaje: 'Proyecto'])
        metaBuenVivir(blank: false, nullable: false, attributes: [mensaje: 'Meta de buen vivir'])
    }

    String toString() {
        return this.proyecto.nombre + " - " + this.metaBuenVivir.descripcion
    }
}
