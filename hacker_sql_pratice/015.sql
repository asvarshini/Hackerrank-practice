-- Retrieve each person's first name, last name, city, and state. Include all people even if they do not have a corresponding address.
SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a
    ON p.personId = a.personId;