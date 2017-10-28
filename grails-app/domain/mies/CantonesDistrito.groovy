package mies

class CantonesDistrito implements Serializable {
    int dstt__id
    int cntn__id
    static auditable = [ignore: []]
    static mapping = {
        table 'cndt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cndt__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'cndt__id'
            dstt__id column: 'dstt__id'
            cntn__id column: 'cntn__id'
        }
    }
    static constraints = {
        dstt__id(blank: true, nullable: true, attributes: [mensaje: 'Distrito'])
        cntn__id(blank: true, nullable: true, attributes: [mensaje: 'Cantón'])
    }
}