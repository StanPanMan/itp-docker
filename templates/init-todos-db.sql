CREATE TABLE 
    IF NOT EXISTS todos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        text TEXT NOT NULL
    );

INSERT INTO    
    todos (id, text) 
VALUES
    (1, 'First todo'),
    (2, 'Second todo'),
    (3, 'Third todo')
ON DUPLICATE KEY UPDATE 
    text = VALUES(text)