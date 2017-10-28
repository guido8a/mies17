package mies

class UnidadEjecutora implements Serializable {
    TipoInstitucion tipoInstitucion
    Provincia provincia
    String codigo
    Date fechaInicio
    Date fechaFin

    UnidadEjecutora padre

    String nombre
    String direccion
    String sigla
    String objetivo
    String telefono
    String fax
    String email
    String observaciones

    int orden

    static auditable = [ignore: []]
    static mapping = {
        table 'unej'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'unej__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'unej__id'
            tipoInstitucion column: 'tpin__id'
            provincia column: 'prov__id'
            codigo column: 'unejcdgo'
            fechaInicio column: 'unejfcin'
            fechaFin column: 'unejfcfn'
            padre column: 'unejpdre'

            nombre column: 'unejnmbr'
            direccion column: 'unejdire'
            sigla column: 'unejsgla'
            objetivo column: 'unejobjt'
            telefono column: 'unejtelf'
            fax column: 'unejfaxx'
            email column: 'unejmail'
            observaciones column: 'unejobsr'
            
            orden column: 'unejordn'
        }
    }
    static constraints = {
        tipoInstitucion(blank: false, nullable: false, attributes: [mensaje: 'Tipo de institución'])
        provincia(blank: true, nullable: true, attributes: [mensaje: 'Provincia de la unidad ejecutora'])
        codigo(size: 1..4, blank: true, nullable: true, attributes: [mensaje: 'Código según el ESIGEF'])
        fechaInicio(blank: true, nullable: true, attributes: [mensaje: 'Fecha de creación'])
        fechaFin(blank: true, nullable: true, attributes: [mensaje: 'Fecha de cierre o final'])
        padre(blank: true, nullable: true, attributes: [mensaje: 'Unidad Ejecutora padre'])

        nombre(size: 1..63, blank: false, attributes: [mensaje: 'Nombre de la entidad o ministerio'])
        direccion(size: 1..127, blank: true, nullable: true, attributes: [mensaje: 'Dirección de la entidad o ministerio'])
        sigla(size: 1..7, blank: true, nullable: true, attributes: [mensaje: 'Sigla identificativa (por ejemplo, MIES)'])
        objetivo(size: 1..1023, blank: true, nullable: true, attributes: [mensaje: 'Objetivo institucional o de la entidad'])
        telefono(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Teléfonos, se los separa con “;”'])
        fax(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Números de fax, se los separa con “;”'])
        email(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Dirección de correo electrónico institucional'])
        observaciones(size: 1..127, blank: true, nullable: true, attributes: [mensaje: 'Observaciones'])
    }

    String toString() {
        return this.nombre
    }
}