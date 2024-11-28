-- Banco PostgreSQL
-- Criando a tabela restaurante
CREATE TABLE restaurante (
    locRef VARCHAR(15) PRIMARY KEY
);

-- Criando a tabela pedido
CREATE TABLE pedido (
    guestCheckId INT PRIMARY KEY, -- guestCheckId duplicado, ajustado para manter consistência
    chkNum INT NOT NULL,
    opnBus DATE NOT NULL,
    locRef VARCHAR(15) NOT NULL,
    CONSTRAINT fk_pedido_locRef FOREIGN KEY (locRef) REFERENCES restaurante (locRef)
);

-- Criando a tabela valor_pedido
CREATE TABLE valor_pedido (
    guestCheckId INT,
    chkTtl FLOAT NOT NULL,
    dscTtl INT NOT NULL,
    payTtl FLOAT NOT NULL,
    CONSTRAINT fk_valor_pedido_guestCheckId FOREIGN KEY (guestCheckId) REFERENCES pedido (guestCheckId)
);

-- Criando a tabela taxas_pedido
CREATE TABLE taxas_pedido (
    guestCheckId INT,
    taxNum SERIAL PRIMARY KEY,
    txblSlsTtl FLOAT NOT NULL,
    taxCollTtl FLOAT,
    taxRate INT NOT NULL,
    type INT NOT NULL,
    CONSTRAINT fk_taxas_pedido_guestCheckId FOREIGN KEY (guestCheckId) REFERENCES pedido (guestCheckId)
);

-- Criando a tabela detailLines
CREATE TABLE detailLines (
    guestCheckLineItemId SERIAL PRIMARY KEY, -- Ajustado para SERIAL
    rvcNum INT NOT NULL,
    detailUTC TIMESTAMP NOT NULL, -- DATE substituído por TIMESTAMP para permitir precisão de tempo
    lastUpdateUTC TIMESTAMP NOT NULL,
    guestCheckId INT NOT NULL,
    CONSTRAINT fk_detailLines_guestCheckId FOREIGN KEY (guestCheckId) REFERENCES pedido (guestCheckId)
);

-- Criando a tabela menuItem
CREATE TABLE menuItem (
    guestCheckLineItemId INT,
    discount FLOAT NOT NULL,
    serviceCharge FLOAT NOT NULL,
    tenderMedia FLOAT NOT NULL,
    errorCode CHAR(5) NOT NULL, -- CHAR(n) ajustado para CHAR(5) como exemplo
    inclTax FLOAT NOT NULL,
    activeTaxes VARCHAR(255) NOT NULL, -- VARCHAR(n) ajustado para VARCHAR(255) como exemplo
    CONSTRAINT fk_menuItem_guestCheckLineItemId FOREIGN KEY (guestCheckLineItemId) REFERENCES detailLines (guestCheckLineItemId)
);
