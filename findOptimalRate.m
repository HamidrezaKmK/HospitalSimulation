function findOptimalRate(input)
    R = 1;
    original_rates = input.rates;
    original_mu = input.mu;
    while true
        for i = 1:length(input.rates)
            input.rates{i} = input.rates{i} + R;
            input.mu = input.mu + R;
        end
        t = getMeanQueueTime(simulate(input));
        if t < 1e-1 || R > 1e10
            break;
        end
        R = R + R;
    end
    
    
    X = linspace(0, R, 50);
    Y = zeros(length(X));
    pnt = 1;
    for x = X
        input.mu = original_mu + x;
        for i = 1:length(input.rates)
            input.rates{i} = original_rates{i} + x;
        end
        Y(pnt) = getMeanQueueTime(simulate(input));
        pnt = pnt+1;
    end
    figure(1);
    plot(X, Y), xlabel("rate added value"), ylabel("mean queue time"), title("optimize rates"); 
end