package mies

class BeneficioSenplades implements Serializable {
    Proyecto proyecto
    int beneficiariosDirectosHombres
    int beneficiariosDirectosMujeres
    int beneficiariosIndirectosHombres
    int beneficiariosIndirectosMujeres
    static auditable = [ignore: []]
    static mapping = {
        table 'bfsp'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'bfsp__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'bfsp__id'
            proyecto column: 'proy__id'
            beneficiariosDirectosHombres column: 'bfspdrhh'
            beneficiariosDirectosMujeres column: 'bfspdrmj'
            beneficiariosIndirectosHombres column: 'bfspidhh'
            beneficiariosIndirectosMujeres column: 'bfspidmj'
        }
    }
    static constraints = {
        proyecto(blank: true, nullable: true, attributes: [mensaje: 'Proyecto'])
        beneficiariosDirectosHombres(blank: true, nullable: true, attributes: [mensaje: 'Beneficiarios Directos Hombres'])
        beneficiariosDirectosMujeres(blank: true, nullable: true, attributes: [mensaje: 'Beneficiarios Directos Mujeres'])
        beneficiariosIndirectosHombres(blank: true, nullable: true, attributes: [mensaje: 'Beneficiarios Indirectos Hombres'])
        beneficiariosIndirectosMujeres(blank: true, nullable: true, attributes: [mensaje: 'Beneficiarios Indirectos Mujeres'])
    }
}