package mies

class Persona implements Serializable {
    String cedula
    String nombre
    String apellido
    String sexo
    String discapacitado
    Date fechaNacimiento
    String direccion
    String telefono
    String mail
    String fax
    String observaciones
    static auditable = [ignore: []]


    static mapping = {
        table 'prsn'
        sort 'apellido'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prsn__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'prsn__id'
            cedula column: 'prsncdla'
            nombre column: 'prsnnmbr'
            apellido column: 'prsnapll'
            sexo column: 'prsnsexo'
            discapacitado column: 'prsndscp'
            fechaNacimiento column: 'prsnfcna'
            direccion column: 'prsndire'
            telefono column: 'prsntelf'
            mail column: 'prsnmail'
            fax column: 'prsnfaxx'
            observaciones column: 'prsnobsr'
        }
    }
    static constraints = {
        cedula(matches: /^[0-2]{1}[0-9]{9}$/, size: 1..13, blank: false, attributes:['mensaje':'Número de cédula de identidad de la persona'])
        nombre(matches:  /^[a-zA-ZñÑ áéíóúÁÉÍÚÓüÜ-]+$/, size: 1..40, blank: false, attributes:['mensaje':'Nombre de la persona'])
        apellido(matches: /^[a-zA-ZñÑ áéíóúÁÉÍÚÓüÜ-]+$/, size: 1..40, blank: false, attributes:['mensaje':'Apellido de la persona'])
        sexo(inList: ["F", "M"], size: 1..1, blank: false, attributes:['mensaje':'Sexo de la persona'])
        discapacitado(matches: /^[0-1]{1}$/, size: 1..1, blank: true, nullable: true, attributes:['mensaje':'Si la persona es discapacitadad o no'])
        fechaNacimiento(max: new Date(), blank: true, nullable: true, attributes:['mensaje':'Fecha de nacimiento de la persona'])
        direccion(matches: /^[a-zA-Z0-9ñÑ .,áéíóúÁÉÍÚÓüÜ#_-]+$/, size: 1..127, blank: true, nullable: true, attributes:['mensaje':'Dirección de la persona'])
        telefono(size: 1..10, blank: true, nullable: true, attributes:['mensaje':'Teléfono de la persona'])
        mail(email: true, size: 1..40, blank: true, nullable: true, attributes:['mensaje':'E-mail de la persona'])
        fax(size: 1..40, blank: true, nullable: true, attributes:['mensaje':'Fax de la persona'])
        observaciones(matches: /^[a-zA-Z0-9ñÑ .,áéíóúÁÉÍÚÓüÜ#_-]+$/, size: 1..127, blank: true, nullable: true, attributes:['mensaje':'Observaciones adicionales'])
    }

    String toString() {
        "${this.nombre} ${this.apellido}"
    }
}