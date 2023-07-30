# Enigma Machine
In the Rotor class, I designed a crucial component of the Enigma machine, which plays a pivotal role in the encryption and decryption process. The Rotor object is created with a string and a character, with the character positioned at the top of the string. To facilitate encryption, the class features a rotate() method, which efficiently rotates the string in a clockwise direction. Additionally, there are two essential methods that retrieve the character at a given position in the string and the index of a particular character in the string. This encapsulation ensures that the internal workings of the Rotor remain hidden from the outside world, promoting data security and safeguarding the encryption process from prying eyes.

Moving on to the Enigma class, I instantiated three Rotors - inner, middle, and outer - representing the key components of the Enigma machine. The Enigma object is designed to take in three integers and a string, ensuring that the correct rotors are matched based on the provided integers. Through well-structured if-statements, the Enigma machine efficiently handles the rotor configurations, ensuring smooth and accurate encryption and decryption processes. The class offers both an encrypt and a decrypt method, effectively implementing the core functionality of the Enigma machine. Moreover, the inclusion of a counter mechanism to track the rotation of the inner rotor, triggering the middle rotor's rotation when the inner rotor completes a full cycle, exemplifies a thoughtful and robust design.

In both the Rotor and Enigma classes, the principles of object-oriented design are evident through the effective use of data hiding and encapsulation. By making all variables private, the classes limit external access, ensuring that sensitive information and encryption patterns are not exposed to unauthorized entities. This approach strengthens the security of the Enigma machine, as the encrypted messages remain protected from potential interception or manipulation. Through well-defined interfaces and well-organized code, the Enigma machine in Java demonstrates the power of object-oriented design, providing a reliable and secure means of encryption and decryption for a wide range of applications.
