import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha

class InquiryForm extends StatefulWidget {
  @override
  _InquiryFormState createState() => _InquiryFormState();
}

class _InquiryFormState extends State<InquiryForm> {
  final _formKey = GlobalKey<FormState>();

  String? fullName;
  String? email;
  String? phone;
  String? comment;
  DateTime? selectedDate;

  // Método para mostrar el selector de fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue.shade700,
            hintColor: Colors.blue.shade700,
            colorScheme: ColorScheme.light(primary: Colors.blue.shade700),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta sobre Propiedad'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Título
                Text(
                  'Ingresa tus datos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),

                // Campo de Nombre Completo
                _buildTextFormField(
                  labelText: 'Nombre Completo',
                  icon: Icons.person_outline,
                  onSaved: (value) => fullName = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu nombre';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Campo de Correo Electrónico
                _buildTextFormField(
                  labelText: 'Correo Electrónico',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => email = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu correo electrónico';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Campo de Teléfono
                _buildTextFormField(
                  labelText: 'Número de Teléfono',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  onSaved: (value) => phone = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu número de teléfono';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Campo de Comentario
                _buildTextFormField(
                  labelText: 'Comentario',
                  icon: Icons.comment_outlined,
                  maxLines: 5,
                  onSaved: (value) => comment = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu comentario';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Campo de Fecha (Selector de Fecha)
                InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Fecha de Consulta',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.blue.shade600.withOpacity(0.5),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.calendar_today, color: Colors.white),
                    ),
                    child: Text(
                      selectedDate != null
                          ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                          : 'Selecciona una fecha',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Botón de Enviar
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Colors.black54,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Aquí enviarías los datos a tu backend
                      print('Nombre: $fullName, Email: $email, Teléfono: $phone, Comentario: $comment, Fecha: $selectedDate');
                    }
                  },
                  child: Text(
                    'Enviar Consulta',
                    style: TextStyle(fontSize: 18, color: Colors.blue.shade700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para crear los TextFormFields con estilo
  Widget _buildTextFormField({
    required String labelText,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    required FormFieldValidator<String>? validator,
    required FormFieldSetter<String>? onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.blue.shade600.withOpacity(0.5),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: TextStyle(color: Colors.red.shade300),
      ),
      style: TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
