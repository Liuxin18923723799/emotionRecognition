function [tree] = decisionTreeLearning(examples, attributes, binary_targets)
  tree.kids = [];
  if (range(binary_targets) == 0)
    tree.class = binary_targets(1);
  elseif (range(attributes) == 0) % why range() and not size()
    tree.class = mode(binary_targets);
  else
    bestAttribute = chooseBestDecisionAttribute(examples, attributes, binary_targets);
    tree.kids = {[],[]};
    for (u = 0 : 1)
      matchingRows = 1 : size(examples, 1);
      for (i = 1 : size(examples, 1))
        if (examples(i, bestAttribute) ~= u)
          matchingRows = matchingRows(matchingRows ~= i);
        end
      end
      
      newExamples = examples(matchingRows,:);
      newTargets = binary_targets(matchingRows,:);
      
      if (size(newExamples, 1) == 0)
        newKid.kids = [];
        newKid.class = mode(binary_targets);
        tree.kids{u + 1} = newKid;
      else
        tree.op = bestAttribute;
        newAttributes = attributes;
        for (i = 1 : length(newAttributes))
          if (newAttributes(i) == bestAttribute)
            newAttributes(i) = -1;
          end
        end
        % why not newAttributes(newAttributes == bestAttribute) = -1 instead of loop
        tree.kids{u + 1} = decisionTreeLearning(newExamples, newAttributes, newTargets);
      end
    end
  end  
