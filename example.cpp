#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

// A simple class to demonstrate C++ features
class Person {
private:
    std::string name;
    int age;

public:
    // Constructor
    Person(const std::string& name, int age) : name(name), age(age) {}

    // Getters
    std::string getName() const { return name; }
    int getAge() const { return age; }

    // Method to display person info
    void display() const {
        std::cout << "Name: " << name << ", Age: " << age << std::endl;
    }
};

// Function to demonstrate templates
template <typename T>
T max(T a, T b) {
    return (a > b) ? a : b;
}

int main() {
    // Vector of persons
    std::vector<Person> people;
    
    // Add some people
    people.push_back(Person("Alice", 30));
    people.push_back(Person("Bob", 25));
    people.push_back(Person("Charlie", 35));
    
    // Display all people
    std::cout << "People:" << std::endl;
    for (const auto& person : people) {
        person.display();
    }
    
    // Sort people by age
    std::sort(people.begin(), people.end(), 
              [](const Person& a, const Person& b) {
                  return a.getAge() < b.getAge();
              });
    
    // Display sorted people
    std::cout << "\nPeople sorted by age:" << std::endl;
    for (const auto& person : people) {
        person.display();
    }
    
    // Demonstrate template function
    std::cout << "\nMax of 10 and 20: " << max(10, 20) << std::endl;
    std::cout << "Max of 3.14 and 2.71: " << max(3.14, 2.71) << std::endl;
    
    return 0;
}
