# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Room
Lab
Event
Equipment.destroy_all
RegularClassRoom.destroy_all
SmartRoom.destroy_all
VideoConferenceRoom.destroy_all
ChemistryLab.destroy_all
BiologyLab.destroy_all
PhysicsLab.destroy_all
ComputerLab.destroy_all
Semester.destroy_all

# Creating equipments

regular_room_equipments = Equipment.create([{name: 'Carteira'}, {name: 'Mesa e Cadeira do professor'}])


blackboard = Equipment.create(name: 'Quadro negro')
whiteboard= Equipment.create(name: 'Quadro branco')
projector = Equipment.create(name: 'Retroprojetor')
projector_screen = Equipment.create(name: 'Tela de projeção')
tv = Equipment.create(name: 'TV')
internet = Equipment.create(name: 'Internet')
computer = Equipment.create(name: 'Computador para uso')
computers = Equipment.create(name: 'Computador para alunos')
cameras = Equipment.create(name: 'Câmeras e microfones')

# Creating rooms

rooms1 = RegularClassRoom.create(capacity: 120, identifier:'S1', nickname:'S1')
rooms1.equipments = regular_room_equipments
rooms1.equipments.push(blackboard)
rooms1.equipments.push(projector)
rooms1.equipments.push(projector_screen)

roomi1 = RegularClassRoom.create(capacity: 60, identifier:'I1', nickname:'I1')
roomi1.equipments = regular_room_equipments
roomi1.equipments.push(whiteboard)
roomi1.equipments.push(tv)

roomi7 = SmartRoom.create(capacity: 40, identifier:'I7', nickname:'I7')
roomi7.equipments = regular_room_equipments
rooms1.equipments.push(blackboard)
rooms1.equipments.push(projector)
rooms1.equipments.push(projector_screen)
rooms1.equipments.push(computer)
rooms1.equipments.push(computers)

roomr = VideoConferenceRoom.create(capacity: 10, identifier:'V1', nickname:'V1')
roomr.equipments = [internet, cameras]

lab1 = ChemistryLab.create(capacity: 10, identifier:'LQ1', nickname:'Laboratório de Química')
lab1 = BiologyLab.create(capacity: 10, identifier:'LB1', nickname:'Laboratório de Biologia')
lab1 = PhysicsLab.create(capacity: 10, identifier:'LF1', nickname:'Laboratório de Física')
lab1 = ComputerLab.create(capacity: 10, identifier:'LC1', nickname:'Laboratório de Computação', for_students: false)
lab1 = ComputerLab.create(capacity: 30, identifier:'LC2', nickname:'Laboratório de Computação', for_students: true)

semester = Semester.create(start_date: Date.new(2017, 02, 01), end_date: Date.new(2017, 07, 01), desc: '01_2017', current: true)

event1 = RepetitiveEvent.create(name: 'Aula 1', responsible: 'Professor 1', start_time: Time.now, end_time: Time.now, days: ['Segunda', 'Quarta'])

schedule = {
    semester.id.to_s => {
        DateTime.new(2017, 02, 01, 10, 0).to_time.to_i => event1.id.to_s,
        DateTime.new(2017, 02, 01, 11, 00).to_time.to_i => event1.id.to_s
    }
}

rooms1.schedule = schedule
rooms1.save!
