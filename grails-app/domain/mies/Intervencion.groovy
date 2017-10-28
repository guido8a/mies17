package mies

class Intervencion implements Serializable {
    Proyecto proyecto
    Sector sector
    SubSector subSector
    static auditable = [ignore: []]
    static mapping = {
        table 'intv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'intv__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'intv__id'
            proyecto column: 'proy__id'
            subSector column: 'sbst__id'
            sector column: 'sctr__id'
        }
    }
    static constraints = {
        proyecto(blank: true, nullable: true, attributes: [mensaje: 'Proyecto'])
        subSector(blank: true, nullable: true, attributes: [mensaje: 'Subsector'])
        sector(blank: true, nullable: true, attributes: [mensaje: 'Sector'])
    }
}